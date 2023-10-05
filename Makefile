all: build
.PHONY: all

# Use local repo to avoid podman accidentally pulling existing remote manifest list and duplicating manifest in it.
REPO :=localhost/scylla-operator-images
PLATFORM :=linux/amd64
JOBS :=1
PARALLEL :=false

MAKE_REQUIRED_MIN_VERSION:=4.2 # for SHELLSTATUS

ifneq "$(MAKE_REQUIRED_MIN_VERSION)" ""
$(call require_minimal_version,make,MAKE_REQUIRED_MIN_VERSION,$(MAKE_VERSION))
endif

# $1 - context dir
# $2 - tag (including repo URI)
# $3 - (optional) FROM replacement (to reference local image if needed)
define build-image
	podman build --format=docker --squash --from='$(3)' --tag='$(2)' '$(1)'
	echo '$(2)' >> '.build_state'

endef

# $1 - source
# $2 - target
define tag-image
	podman tag '$(1)' '$(2)'
	echo '$(2)' >> '.build_state'

endef

# $1 - tag (including repo URI)
define publish-image
	podman manifest push '$(1)'

endef

build:
	REPO_REF='$(REPO)' PLATFORM='$(PLATFORM)' JOBS='$(JOBS)' PARALLEL='$(PARALLEL)' ./hack/build-images.sh
.PHONY: build

publish-last-build:
	$(foreach i,$(shell cat '.build_state')$(if $(filter $(.SHELLSTATUS),0),,$(error can not read .build_state)),$(call publish-image,$(i)))
.PHONY: publish-last-build

clean:
	$(RM) '.build_state'
.PHONY: clean
