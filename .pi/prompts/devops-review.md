---
description: Review infrastructure changes for operational and security risks
---
Review the current infrastructure changes. Focus on Terraform replacement or
destruction risk, Kubernetes security contexts and RBAC, secret exposure, shell
quoting and error handling, image pinning, and CI permissions. Do not run
apply, destroy, deployment, or production commands. Return findings ordered by
severity with file and line references.
