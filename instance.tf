data "aws_ami" "service" {
    most_recent = true

    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }

    owners = ["679593333241"]

}



resource "aws_instance" "service" {
    ami = "ami-0fed77069cd5a6d6c"
    vpc_security_group_ids = ["${aws_security_group.service.id}"]
    subnet_id = "${module.vpc.public_subnets[0]}"
    instance_type = "r5.xlarge"
    availability_zone = "ap-southeast-1a"
    key_name = "CL-test-tf"

    tags = {
        Name = "CL-ec2"
    }
    # provisioner "remote-exec" {
    #     inline = [
    #         "sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5",
    #         "echo 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list",
    #         "sudo apt-get update",
    #         "sudo apt-get install -y mongodb-org-shell"
    #     ]
    # }

    # connection {
    #     host = aws_instance.service.id
    #     type = "ssh"
    #     user = "ubuntu"
    #     private_key = "${tls_private_key.service.private_key_pem}"
    # }
  
}

# resource "tls_private_key" "service" {
#     algorithm = "RSA"
#     rsa_bits = 4096
# }

# resource "aws_key_pair" "service" {
#     key_name = "tf-${var.name}-ec2"
#     public_key = "${tls_private_key.service.public_key_openssh}"
# }

# resource "local_file" "service_private_key" {
#     content = "${tls_private_key.service.private_key_pem}"
#     filename = "${aws_key_pair.service.key_name}"
#     # provisioner "local-exec" {
#     #     command = "chmod 4000 ${aws_key_pair.service.key_name}"
#     # }
  
# }

resource "aws_ebs_volume" "ec2-test-ebs" {
  availability_zone = "ap-southeast-1a"
  size              = 100
  iops              = 16000
  type              = "gp3"
  throughput        = 1000
  
  tags = {
    Name = "ec2-testebs"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ec2-test-ebs.id
  instance_id = aws_instance.service.id
  // 强制分离   遭遇 IncorrectState: Volume 'vol-0b0246fa4ea406c6c' is in the 'available' state. 问题
  // 线上谨慎使用.
  // 删除EC2 实例前,需要先将磁盘umount
  force_detach = true    

}






resource "aws_instance" "service2" {
    ami = "ami-0fed77069cd5a6d6c"
    vpc_security_group_ids = ["${aws_security_group.service.id}"]
    subnet_id = "${module.vpc.public_subnets[0]}"
    instance_type = "r5.xlarge"
    availability_zone = "ap-southeast-1a"
    key_name = "CL-test-tf"

    tags = {
        Name = "CL-ec2-2"
    }
    
  
}



resource "aws_ebs_volume" "ec2-test-ebs2" {
  availability_zone = "ap-southeast-1a"
  size              = 100
  iops              = 16000
  type              = "gp3"
  throughput        = 1000
  
  tags = {
    Name = "ec2-testebs-2"
  }
}

resource "aws_volume_attachment" "ebs_att2" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ec2-test-ebs2.id
  instance_id = aws_instance.service2.id
  // 强制分离   遭遇 IncorrectState: Volume 'vol-0b0246fa4ea406c6c' is in the 'available' state. 问题
  // 线上谨慎使用.
  // 删除EC2 实例前,需要先将磁盘umount
  force_detach = true    

}


resource "aws_instance" "service3" {
    ami = "ami-0fed77069cd5a6d6c"
    vpc_security_group_ids = ["${aws_security_group.service.id}"]
    subnet_id = "${module.vpc.public_subnets[0]}"
    instance_type = "r5.xlarge"
    availability_zone = "ap-southeast-1a"
    key_name = "CL-test-tf"

    tags = {
        Name = "CL-ec2-3"
    }
    
  
}



resource "aws_ebs_volume" "ec2-test-ebs3" {
  availability_zone = "ap-southeast-1a"
  size              = 100
  iops              = 16000
  type              = "gp3"
  throughput        = 1000
  
  tags = {
    Name = "ec2-testebs-3"
  }
}

resource "aws_volume_attachment" "ebs_att3" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ec2-test-ebs3.id
  instance_id = aws_instance.service3.id
  // 强制分离   遭遇 IncorrectState: Volume 'vol-0b0246fa4ea406c6c' is in the 'available' state. 问题
  // 线上谨慎使用.
  // 删除EC2 实例前,需要先将磁盘umount
  force_detach = true    

}


resource "aws_instance" "service4" {
    ami = "ami-0fed77069cd5a6d6c"
    vpc_security_group_ids = ["${aws_security_group.service.id}"]
    subnet_id = "${module.vpc.public_subnets[0]}"
    instance_type = "r5.xlarge"
    availability_zone = "ap-southeast-1a"
    key_name = "CL-test-tf"

    tags = {
        Name = "CL-ec2-4"
    }
    
  
}



resource "aws_ebs_volume" "ec2-test-ebs4" {
  availability_zone = "ap-southeast-1a"
  size              = 100
  iops              = 16000
  type              = "gp3"
  throughput        = 1000
  
  tags = {
    Name = "ec2-testebs-4"
  }
}

resource "aws_volume_attachment" "ebs_att4" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ec2-test-ebs4.id
  instance_id = aws_instance.service4.id
  // 强制分离   遭遇 IncorrectState: Volume 'vol-0b0246fa4ea406c6c' is in the 'available' state. 问题
  // 线上谨慎使用.
  // 删除EC2 实例前,需要先将磁盘umount
  force_detach = true    

}