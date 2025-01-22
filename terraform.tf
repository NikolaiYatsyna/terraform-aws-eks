terraform {
  required_version = "1.10.5"
  required_providers {
    aws = {
      version = "5.82.2"
      source  = "hashicorp/aws"
    }
    cloudinit = {
      version = "2.3.5"
      source  = "hashicorp/cloudinit"
    }
    kubernetes = {
      version = "2.35.1"
      source  = "hashicorp/kubernetes"
    }
    time = {
      version = "0.12.1"
      source  = "hashicorp/time"
    }
    tls = {
      version = "4.0.6"
      source  = "hashicorp/tls"
    }
    null = {
      version = "3.2.3"
      source  = "hashicorp/null"
    }
  }
}
