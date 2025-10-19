resource "aws_key_pair" "imported_key" {
  key_name = "app_server_key"
  public_key = file("app_server_key.pub")
}

resource "aws_instance" "app-server" {
  ami = var.amiID
  instance_type = var.instance_type
  key_name = aws_key_pair.imported_key.key_name
  vpc_security_group_ids = [aws_security_group.app_server_sg.id]
  associate_public_ip_address = true
  
  root_block_device {
    volume_size = 25
    volume_type = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "app-server"
  }
}