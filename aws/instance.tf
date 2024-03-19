
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.machine_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = [aws_security_group.from_terraform.id]
  tags = {
    Name = "CreatedFromTerraform"
  }
  user_data = file("${path.module}/init.sh")

  # connection settings to be used by provisioners
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }

  # file, local-exec, remote-exec
  # in case of error, it will mark the instance as taint
  provisioner "file" {
    source      = "id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

  }
  provisioner "file" {
    content     = "Written from terraform"
    destination = "/tmp/readme.md"
  }
}
