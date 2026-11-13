# SPDX-FileCopyrightText: 2026 - Canonical Ltd
# SPDX-License-Identifier: Apache-2.0

variable "model_uuid" {
  description = "UUId of the Juju model to deploy to"
  type        = string
}

variable "name" {
  description = "Name of the ceph-proxy application"
  type        = string
}

variable "charm_channel" {
  description = "Operator channel for ceph-proxy"
  type        = string
}

variable "charm_revision" {
  description = "Operator channel revision for ceph-proxy"
  type        = string
  default     = null
}

variable "charm_base" {
  description = "Base for ceph-proxy"
  type        = string
  default     = "ubuntu@24.04"
}

variable "machine_ids" {
  description = "Machines to place ceph-proxy units on (storage-nodes)"
  type        = list(string)
}

variable "charm_config" {
  description = "ceph-proxy config (fsid, monitor-hosts); admin-key must not be set"
  type        = map(string)
  default     = {}
}

variable "user_keys" {
  description = "User keys for the secret, in user-keys format: client.<user>:<key>"
  type        = string
  sensitive   = true
}
