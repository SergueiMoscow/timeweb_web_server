data "twc_os" "ubuntu" {
  name    = "ubuntu"
  version = "22.04"
}

data "twc_presets" "this" {
  location  = "ru-1"
  disk_type = "nvme"
  cpu       = 1
  ram       = 1024
}

resource "twc_server_ip" "ipv4" {
  source_server_id = twc_server.this.id
  type             = "ipv4"
}

resource "twc_server" "this" {
  name       = var.server_name
  comment    = "Managed by terraform"
  os_id      = data.twc_os.ubuntu.id
  preset_id  = data.twc_presets.this.id
  cloud_init = data.template_file.cloudinit.rendered
}

resource "twc_ssh_key" "key" {
  name = "ssh_public_key"
  body = file(var.ssh_public_key_file)
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username       = var.vms_ssh_user
    ssh_public_key = file(var.ssh_public_key_file)
  }
}

resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/ansible/hosts.tftpl",
    {
      name = twc_server.this.name
      ipv4 = twc_server_ip.ipv4.ip
    }
  )
  filename = "${abspath(path.module)}/ansible/hosts.ini"
}

resource "local_file" "playbook_templatefile" {
  content = templatefile("${path.module}/ansible/playbook.tftpl",
    {
      user = var.vms_ssh_user
      hostname = var.server_name
    }
  )
  filename = "${abspath(path.module)}/ansible/playbook.yml"
}