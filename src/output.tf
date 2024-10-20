# output "cloudinit_rendered" {
#   value = data.template_file.cloudinit.rendered
# }

output "server_ip" {
  value = twc_server_ip.ipv4
}