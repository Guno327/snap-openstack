# SPDX-FileCopyrightText: 2026 - Canonical Ltd
# SPDX-License-Identifier: Apache-2.0

output "application_name" {
  value = juju_application.ceph-proxy.name
}
