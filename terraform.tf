terraform {
  required_version = "1.7.5"
  required_providers {
    aws = {
      version = "5.40.0"
      source  = "hashicorp/aws"
    }
    cloudinit = {
      version     = "2.2.0"
      source = "hashicorp/cloudinit"
    }
    kubernetes = {
      version     = "2.17.0"
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
