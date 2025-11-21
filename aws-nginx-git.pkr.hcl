packer {
    required_version = ">=1.9.0"

    required_plugins {
        amazon = {
            source = "github.com/hashicorp/amazon"
            version = ">=1.2.0"
        }
    }
}


#-----------------------------
# source: how the AMI is built
#-----------------------------

source "amazon-ebs" "nginx-git" {
    region = "eu-west-1"
    instance_type = "t3.micro"
    ssh_username = "ec2-user"
    source_ami= "ami-08b6a2983df6e9e25"
    ami_name = "nginx_git_by_packer"
    ami_virtualization_type = "hvm"
}

#------------------------------
# build:: source + provisioning
#------------------------------

build {
    name = "nginx_git_ami_build"

    sources = [
        "source.amazon-ebs.nginx-git"
    ]

    provisioner "shell" {
        inline = [
            "sudo yum update -y",
            "sudo yum install nginx -y",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx",
            " echo '<h1> Hello from Techbleat - Built by Packer </h1>' | sudo tee /usr/share/nginx/html/index.html",
            "sudo yum install git -y"
        ]
    }

    post-processor "shell-local" {
        inline = ["echo 'AMI build id finished' "]
    }
}