#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

# Register QEMU binfmt_misc handlers to enable cross-architecture builds
# (e.g. building linux/arm64 images on an amd64 host).
#
# The base image (quay.io/buildah/stable) already ships with:
# - qemu-user-static binaries (e.g. /usr/bin/qemu-aarch64-static)
# - binfmt.d configuration files (/usr/lib/binfmt.d/qemu-*.conf)
# - systemd-binfmt tool (part of systemd-udev)
#
# What's missing at container startup is:
# 1. The binfmt_misc kernel pseudo-filesystem isn't mounted in containers by default.
# 2. The binfmt handlers from /usr/lib/binfmt.d/ aren't registered until something
#    reads the conf files and writes them into /proc/sys/fs/binfmt_misc/register.
#
# The mount requires --privileged or CAP_SYS_ADMIN. When running without privileges,
# the mount silently fails and cross-arch builds won't be available, but native-arch
# builds continue to work normally.

# Mount the binfmt_misc filesystem so that handlers can be registered.
mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc 2>/dev/null || true

# Use systemd-binfmt to register all handlers from /usr/lib/binfmt.d/.
# It's a no-op when binfmt_misc isn't mounted (non-privileged containers).
/usr/lib/systemd/systemd-binfmt

exec "$@"
