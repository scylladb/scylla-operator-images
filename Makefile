all: build
.PHONY: all

REPO :=quay.io/scylladb/scylla-operator-images

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
	podman push '$(1)'

endef

build:
	> '.build_state'
	$(call build-image,./base/ubuntu/20.04,$(REPO):base-ubuntu-20.04,)
	# TODO: switch this to the latest release when we migrate scylla-operator to use an explicit version so Major upgrades go through CI
	$(call tag-image,$(REPO):base-ubuntu-20.04,$(REPO):base-ubuntu)
	$(call build-image,./base/ubuntu/22.04,$(REPO):base-ubuntu-22.04,)
	$(call build-image,./golang/1.18,$(REPO):golang-1.18,$(REPO):base-ubuntu-22.04)
	$(call build-image,./golang/1.19,$(REPO):golang-1.19,$(REPO):base-ubuntu-22.04)
	$(call build-image,./golang/1.20,$(REPO):golang-1.20,$(REPO):base-ubuntu-22.04)
	$(call build-image,./kube-tools/latest,$(REPO):kube-tools,)
	$(call build-image,./node-setup,$(REPO):node-setup,$(REPO):base-ubuntu-22.04)
.PHONY: build

publish-last-build:
	$(foreach i,$(shell cat '.build_state')$(if $(filter $(.SHELLSTATUS),0),,$(error can not read .build_state)),$(call publish-image,$(i)))
.PHONY: publish-last-build

clean:
	$(RM) '.build_state'
.PHONY: clean
