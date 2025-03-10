resource "aws_instance" "ourfirst" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  key_name = "assignment_09"
  security_groups = [aws_security_group.test_sg.id]
}

resource "aws_security_group" "test_sg" {
  name = "securitygroup2"
  description = "Allow http and ssh ports"
  tags = {
    Name = "terrafrom_securitygroup"
  }
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {  #allowing http port
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #from anywhere
    }

    egress{
    from_port = 0
    to_port = 0
    protocol = "-1" #  any port
    cidr_blocks = ["0.0.0.0/0"] # anywhere
  }
}

provider "aws" {
  region     = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "kedhar-workspace" #bucketname
    key = "Assignment" #path
    region = "ap-south-1"
    # dynamodb_table = "terraform_state_lock_file"
    use_lockfile = true
  }
}

output "instance_private_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.ourfirst.private_ip
}
