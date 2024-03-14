terraform {
  required_version = "1.7.5"
  required_providers {
    aws = {
      version = "4.54.0"
      source  = "hashicorp/aws"
    }
    cloudinit = {
      version     = "2.2.0"
      source = "hashicorp/cloudinit"
    }
    kubernetes = {
      version     = "2.27.0"
      source = "hashicorp/kubernetes"
    }
    time = {
      version     = "0.9.1"
      source = "hashicorp/time"
    }
    tls = {
      version     = "4.0.4"
      source = "hashicorp/tls"
    }
  }
}
