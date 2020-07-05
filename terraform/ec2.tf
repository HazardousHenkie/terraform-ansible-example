
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web" {
  count = 1
  instance_type = var.instance_type
  ami = data.aws_ami.amazon-linux-2.id
  key_name = var.key_name
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  tags = {
    Name = var.ec2_name
  }

  connection {
    host = self.public_ip
    user = "ec2-user"
    private_key = file(var.key_file)
  }

  provisioner "remote-exec" {
    inline = ["sudo yum install python -y"]
  }

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -u ec2-user --private-key ${var.key_file} -i '${self.public_ip},' ../ansible/provision.yml"
  }
}