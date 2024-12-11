terraform {
  required_version = "1.10.2"
  required_providers {
    aws = {
      version = "5.42.0"
      source  = "hashicorp/aws"
    }
    cloudinit = {
      version = "2.3.3"
      source  = "hashicorp/cloudinit"
    }
    kubernetes = {
      version = "2.27.0"
      source  = "hashicorp/kubernetes"
    }
    time = {
      version = "0.11.1"
      source  = "hashicorp/time"
    }
    tls = {
      version = "4.0.5"
      source  = "hashicorp/tls"
    }
    null = {
      version = "3.2.2"
      source  = "hashicorp/null"
    }
  }
}
