resource "aws_vpc" "main" {
  cidr_block       = "100.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demo-vpc-terraform"
    Purpose = "Jenkins Terraform Demo"
  }
}
