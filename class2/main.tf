resource "aws_instance" "foo" {
  ami                         = "ami-02f3f602d23f1659d" # us-west-2
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
}

# creates a key pair
resource "aws_key_pair" "class2" {
  key_name   = "class2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}