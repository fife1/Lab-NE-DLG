terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = "2.6.0"
    }
  }
}

provider "equinix" {
  # Configuration options 
  # Credentials for only Equinix Metal resources 
  auth_token = "my_auth_token"

  client_id = "my_client_id"

  client_secret = "my_client_secret"
}


# Create self configured single Catalyst 8000V (Autonomous Mode) router with license token

resource "equinix_network_device" "faiqlabda" {
  name                 = "faiqlabda"
  metro_code           = "DA"
  type_code            = "C8000V"
  self_managed         = true
  byol                 = true
  package_code         = "network-essentials"
  notifications        = ["fnawaz@equinix.com"]
  hostname             = "faiqq4"
  account_number       = 1
  version              = "17.09.04a"
  core_count           = 2
  term_length          = 1
  additional_bandwidth = 5
  acl_template_id      = "put_your_acl_ID_here"

  ssh_key {
    username = "faiq"
    key_name = "faiqpublickey"
  }
}

resource "equinix_network_device" "faiqlabdc" {
  name                 = "faiqlabdc"
  metro_code           = "DC"
  type_code            = "C8000V"
  self_managed         = true
  byol                 = true
  package_code         = "network-essentials"
  notifications        = ["fnawaz@equinix.com"]
  hostname             = "faiqq4dc"
  account_number       = 1
  version              = "17.09.04a"
  core_count           = 2
  term_length          = 1
  additional_bandwidth = 5
  acl_template_id      = "put_your_acl_ID_here"

  ssh_key {
    username = "faiq"
    key_name = "faiqpublickey"
  }
}
resource "equinix_network_device_link" "faiqdlg" { 
name   = "test-link"
project_id  = "my_project_id"
device { 
id        = equinix_network_device.faiqlabda.uuid
interface_id = 4
}
device {
id       = equinix_network_device.faiqlabdc.uuid
interface_id = 4
}
link {
    account_number  =  1_gjhbe%6
    src_metro_code  = equinix_network_device.faiqlabda.metro_code
    dst_metro_code  = equinix_network_device.faiqlabdc.metro_code
    throughput      = "50"
    throughput_unit = "Mbps"
  }
}
