variable "subnet_id" {
    description = "Subnet id to put the EC2 instance"
    type        = string
  
}

variable "vpc_id" {
    description = "vpc id of the EC2 instance"
    type        = string
  
}

locals {
    user_data = <<EOF
#!/bin/bash -xe
  yum -y update
  echo "Hello from user-data!"
  yum install httpd -y
  systemctl start httpd
  systemctl enable httpd
  echo "<h1>Welcome to Bolt</h1>" >> /var/www/html/index.html
EOF
}