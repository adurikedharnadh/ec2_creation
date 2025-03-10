resource "aws_instance" "ourfirst" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  key_name = "assignment_09"
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
