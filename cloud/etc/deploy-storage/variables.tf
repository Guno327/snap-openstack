# SPDX-FileCopyrightText: 2025 - Canonical Ltd
# SPDX-License-Identifier: Apache-2.0

variable "model" {
  # note(himax16): Should be renamed to model_uuid
  description = "UUID of the Juju machine model to deploy into"
  type        = string
}

variable "cinder-volumes" {
  description = "Cinder Volume application configuration"
  type = map(object({
    application_name               = string
    charm_channel                  = string
    charm_revision                 = number
    charm_config                   = map(string)
    machine_ids                    = list(string)
    endpoint_bindings              = set(map(string))
    keystone-offer-url             = string
    amqp-offer-url                 = string
    database-offer-url             = string
    cert-distributor-offer-url     = optional(string)
    enable-telemetry-notifications = bool
  }))
  default = {}
}

variable "backends" {
  description = "Map of storage backend configurations"
  type = map(object({
    principal_application = string
    charm_name            = string
    charm_base            = string
    charm_channel         = string
    charm_revision        = number
    charm_config          = map(string)
    endpoint_bindings     = set(map(string))
    secrets               = map(string)
    integrations = optional(map(object({
      application         = optional(string)
      endpoint            = optional(string)
      offer_url           = optional(string)
      offering_controller = optional(string)
    })), {})
    ceph_proxy = optional(object({
      charm_channel  = string
      charm_revision = optional(number)
      charm_base     = optional(string, "ubuntu@24.04")
      machine_ids    = list(string)
      charm_config   = map(string)
      user_keys      = string
    }))
  }))
  default = {}
}

variable "offering_controllers" {
  description = "Controllers hosting offers consumed by storage backends"
  type = map(object({
    controller_addresses = string
    username             = string
    password             = string
    ca_certificate       = string
  }))
  default   = {}
  sensitive = true
}
