# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.1"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.2.2"
  }
}

provider "random" "this" {}
provider "null" "this" {}

component "pet" {
  source = "./pet"

  inputs = {
    prefix = var.prefix
  }

  providers = {
    random = provider.random.this
    null = provider.nulls.this
  }
}

component "nulls" {
  source = "./nulls"

  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }

  providers = {
    null = provider.null.this
  }
}

component "nils" {
  source = "./nulls"

  inputs = {
    pet = component.pet.name
    instances = component.pet.number
  }

  providers = {
    null = provider.null.this
  }
}

output "my-output" {
  description = "This would be my component output from the pet component"
  type        = string
  value       = "the string expression"
  sensitive   = false
  ephemeral   = false
}

output "list-output" {
  description = "Here's a list of strings"
  type        = list(string)
  value       = ["us-west-1a", "us-west-1c"]
  sensitive   = false
  ephemeral   = false
}

output "map-output" {
  description = "Here's a map of strings"
  type        = map(string)
  value       = {
    "first" = "us-west-1a"
    "second" = "us-west-1c"
  }
  sensitive   = false
  ephemeral   = false
}

output "sensitive-output" {
  description = "Here's a sensitive number"
  type        = number
  value       = 12345
  sensitive   = true
  ephemeral   = false
}
