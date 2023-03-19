# creates a key pair
resource "aws_key_pair" "class2" {
  key_name   = "class2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# creates sec group
resource "aws_security_group" "class2" {
  name        = "class2"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}





resource "aws_instance" "foo" {
  ami                         = "ami-02f3f602d23f1659d" # us-west-2
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  key_name                    = aws_key_pair.class2.key_name
  vpc_security_group_ids = [
    aws_security_group.class2.id,
  ]
}

