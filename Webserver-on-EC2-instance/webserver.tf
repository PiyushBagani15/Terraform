provider "aws" {
     region = "ap-south-1"
     profile = "default"
}
resource "aws_instance" "webos1" {
  ami           = "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  security_groups =  [ "WebPort" ]
  key_name = "key1515"

  tags = {
    Name = "Web Server by TF"
  }
}
resource "null_resource"  "nullremote1" {

connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("/home/ec2-user/key1515.pem")
    host     = aws_instance.webos1.public_ip
  }
provisioner "remote-exec" {
    inline = [
      "sudo yum  install httpd  -y",
      "sudo  yum  install php  -y",
      "sudo systemctl start httpd",
      "sudo systemctl start httpd"
    ]
  }

}

resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.webos1.availability_zone
  size              = 1

  tags = {
    Name = "Web Server HD by TF"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.webos1.id
  force_detach = true
}

resource "null_resource"  "nullremote2" {

connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("/home/ec2-user/key1515.pem")
    host     = aws_instance.webos1.public_ip
  }
provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/xvdc",
      "sudo  mount /dev/xvdc  /var/www/html",
      "sudo yum install git -y",
      "sudo git clone https://github.com/vimallinuxworld13/gitphptest.git   /var/www/html/web"
    ]
  }

}
#resource "null_resource"  "nullremote5" {
#provisioner "local-exec" {
#  command = "chrome http://65.0.103.197/web/index.php"
# }
#}
#the above command if ran in windows command prompt then it will directly open chrome with the given link
