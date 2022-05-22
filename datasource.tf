data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["636521895949"]

  filter {
    name   = "image-id"
    values = ["ami-055232d90e0f3c7cc"]
  }
}