output "agent-ips" {
  value = "${join(",", digitalocean_droplet.dcos_agent.*.ipv4_address)}"
}
output "agent-public-ips" {
  value = "${join(",", digitalocean_droplet.dcos_public_agent.*.ipv4_address)}"
}
output "master-ips" {
  value = "${join(",", digitalocean_droplet.dcos_master.*.ipv4_address)}"
}
output "bootstrap_ip" {
  value = "${digitalocean_droplet.dcos_bootstrap.ipv4_address}"
}
output "DCOS Admin UI" {
  value = "http://${digitalocean_droplet.dcos_master.0.ipv4_address}/"
}
output "Marathon Admin UI" {
  value = "http://${digitalocean_droplet.dcos_master.0.ipv4_address}:8080/"
}
output "Exhibitor Admin UI" {
  value = "http://${digitalocean_droplet.dcos_master.0.ipv4_address}:8181/"
}