variable "region" {
    type = string
    default = "ap-northeast-1"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    type = string
    default = "kyle-sun-key"
}

variable "key_file" {
    type = string
    default = "~/.ssh/kyle-sun-key.pem"
}

variable "ec2_name" {
    type = string
    default = "Terraform-example"
}

variable "lb_name" {
    type = string
    default = "Terraform-example-lb"
}