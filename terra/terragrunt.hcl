terraform {
  source = "./terraform"
}

inputs = {
  aws_region        = "eu-central-1"
  availability_zone = "eu-central-1a"
  ami_id            = "ami-00060fac2f8c42d30"
  instance_type     = "t2.micro"
}