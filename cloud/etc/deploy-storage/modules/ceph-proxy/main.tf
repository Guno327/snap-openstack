# SPDX-FileCopyrightText: 2026 - Canonical Ltd
# SPDX-License-Identifier: Apache-2.0

terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "= 2.3.1"
    }
  }
}

provider "juju" {}

data "juju_model" "model" {
  uuid = var.model_uuid
}

# User keys for the backend, readable by only this proxy
resource "juju_secret" "user-keys" {
  model_uuid = data.juju_model.model.uuid
  name       = "${var.name}-user-keys"
  value = {
    uuid = var.model_uuid
  }
}

resource "juju_access_secret" "user-keys-access" {
  model_uuid   = data.juju_model.model.uuid
  secret_id    = juju_secret.user-keys.secret_id
  applications = [juju_application.ceph-proxy.name]
}

# Keys only ceph-proxy (no admin-key)
resource "juju_application" "ceph-proxy" {
  name       = var.name
  model_uuid = data.juju_model.model.uuid
  machines   = toset(var.machine_ids)

  charm {
    name     = "ceph-proxy"
    channel  = var.charm_channel
    revision = var.charm_revision
    base     = var.charm_base
  }

  config = merge(var.charm_config, {
    user-keys-secret = juju_secret.user-keys.secret_uri
  })
}
