output "app_server_public_ip" {
  description = "The public IP address of the app server"
  value = aws_instance.app-server.public_ip
}