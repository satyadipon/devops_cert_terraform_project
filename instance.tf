resource "aws_instance" "jenkins" {
	ami						= "ami-0d13e3e640877b0b9"
	instance_type			= "t2.micro"
	availability_zone		= "ap-south-1a"
	key_name				= "jen-key"
	vpc_security_group_ids	= [aws_security_group.sd_grp.id]

provisioner "remote-exec" {
	inline = [
		"sudo yum update –y",
		"sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
		"sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
		"sudo yum upgrade",
		"sudo dnf install java-11-amazon-corretto -y",
		"sudo dnf install python3 -y",
		"sudo yum install jenkins -y",
		"sudo systemctl enable jenkins",
		"sudo systemctl start jenkins"
		]
}

connection {
	type		= "ssh"
	host		= self.public_ip
	user		= "ec2-user"
	private_key	= file("./jen-key.pem")
 }
 	tags = {
 	Name = "Jenkins-Java-Python-Server"
 	}
}