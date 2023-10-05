#!/usr/bin/env bash
set -euExo pipefail
shopt -s inherit_errexit

if [ -z ${REPO_REF+x} ]; then
  echo "REPO_REF can't be empty" > /dev/stderr
  exit 2
fi

if [ -z ${PLATFORM+x} ]; then
  echo "PLATFORM can't be empty" > /dev/stderr
  exit 2
fi

if [ -z ${JOBS+x} ]; then
  echo "JOBS can't be empty" > /dev/stderr
  exit 2
fi

if [ -z ${PARALLEL+x} ]; then
  echo "PARALLEL can't be empty" > /dev/stderr
  exit 2
fi

skip_header=true
while IFS=, read -r context_dir image_tag from_tag
do
  if "${skip_header}"; then
    skip_header=false
    continue
  fi

  image_ref="${REPO_REF}:${image_tag}"
  if [[ -z "${from_tag}" ]]; then
    from_ref=""
  else
    from_ref="${REPO_REF}:${from_tag}"
  fi

  buildah build --squash --format=docker --manifest="${image_ref}" --platform="${PLATFORM}" --jobs="${JOBS}" --from="${from_ref}" "${context_dir}" &
  if [[ "${PARALLEL}" != "true" ]]; then
    wait $!
  fi
done < image-spec.csv

wait
