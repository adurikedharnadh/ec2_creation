resource "aws_instance" "ourfirst" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  key_name = "assignment_09"
  security_groups = ["${aws_security_group.example.name}"]
}


resource "aws_security_group" "example" {
  name   = "security-group"
 ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }
   ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
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
