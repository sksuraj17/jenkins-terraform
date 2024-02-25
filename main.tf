resource "aws_instance" "myinstance" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.nano"
  subnet_id = "subnet-0db8bbd30fd7e1775"

  tags = {
    Terraform = "True"
    Jenkins   = "True"
  }
}