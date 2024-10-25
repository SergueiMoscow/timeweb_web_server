variable "server_name" {
  type = string
}
variable "tw_token" {
  type = string
}

variable "vms_ssh_user" {
  type = string
}

variable "ssh_public_key_file" {
  type = string
}

variable "vault_address" {
  type = string
}

variable "vault_token" {
  type = string
}

variable "vault_tw_token_path" {
  type = string
}

variable "portainer_admin_password_hash" {
  type = string
}

variable "nginx_config" {
  description = "Nginx configuration details"
  type = object({
    host             = string
    forward_host     = string
    forward_port     = number
    current_email    = string
    current_password = string
    new_email        = string
    new_password     = string
    new_username     = string
    new_nickname     = string
    advanced_config  = string
  })
}