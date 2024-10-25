resource "null_resource" "run_ansible" {
  depends_on = [twc_server.this] # Зависимость от созданного сервера

  provisioner "local-exec" {
    command = <<EOT
      sleep 60  # Задержка, чтобы дождаться окончания cloud-init
      bash ${path.module}/check_ssh.sh ${twc_server_ip.ipv4.ip}
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${path.module}/ansible/hosts.ini ${path.module}/ansible/playbook.yml
    EOT
  }

  triggers = {
    ipv4 = twc_server_ip.ipv4.ip
  }

  lifecycle {
    create_before_destroy = true
  }
}