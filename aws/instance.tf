
resource "aws_instance" "web" {
  ami                    = var.image_id
  instance_type          = var.machine_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = [aws_security_group.from_terraform.id]
  tags = {
    Name = "CreatedFromTerraform"
  }
  user_data = file("${path.module}/init.sh")
}
