# https://timeweb.cloud/docs/terraform/nachalo-raboty-s-terraform
terraform {
  required_providers {
    twc = {
      source  = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
      version = "~> 1.3.8"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~>4.4.0"
    }
  }
  required_version = "~> 1.9.8"
}

provider "twc" {
  token = var.tw_token
}

provider "vault" {
  address         = var.vault_address
  skip_tls_verify = true
  token           = "education"
  # checkov:skip=CKV_SECRET_6: education
}

