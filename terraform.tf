terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws        = ">= 4.51.0"
    helm       = ">= 2.8.0"
    kubernetes = ">= 2.17.0"
  }
}
