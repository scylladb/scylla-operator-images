# Scylla Operator Shared Images
This repository contains the source for shared images used by Scylla Operator projects.

We do not provide any support or compatibility guaranties for these images as their sole purpose is only to provide 
a common base in our projects. 

## Dropping support for images versions in this repository

We need to maintain support for base images (`golang` and `base/ubi`) used in Scylla Operator and local-csi-driver projects in case of security issues or critical bugs.

Before dropping support for any base image version, please make sure there are no images relying on it.

#### Scylla Operator images
Look up Dockerfiles of the supported version of Scylla Operator (e.g., https://github.com/scylladb/scylla-operator/blob/v1.17/Dockerfile).

#### local-csi-driver images
The oldest supported local-csi-driver version is determined by the oldest supported Scylla Operator version. Look up
local-csi-driver version used in the Operator manifests (e.g., https://github.com/scylladb/scylla-operator/blob/v1.17/examples/common/local-volume-provisioner/local-csi-driver/50_daemonset.yaml).
Then, look up Dockerfiles of the supported version of local-csi-driver (e.g., https://github.com/scylladb/local-csi-driver/blob/v0.5.0/images/local-csi-driver/Dockerfile).
