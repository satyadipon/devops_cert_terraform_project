resource "aws_instance" "jenkins" {
	ami						= "ami-080995eccd0180687"
	instance_tye			= "t2.micro"
	availability_zone		= "ap-south-1a"
	key_name				= "jenkins-key"
	vpc_security_group_ids	= [aws_security_group.sd_grp.id]

provisioner "remote-exe" {
	inline = [
		"sudo yum update –y",
		"sudo amazon-linux-extras install java-openjdk11 -y",
		"sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo",
		"sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
		"sudo yum install jenkins -y",
		"sudo systemctl enable jenkins",
		"sudo systemctl start jenkins"
		]
}

connection {
	type		= "ssh"
	host		= self.public_ip
	user		= "ec2-user"
	private_key	= file("./jenkins-key.pem")
 }
 	tags = {
 	Name = "Jenkins-Server"
 	}
}

resource "aws_instance" "ansible" {
	ami						= "ami-080995eccd0180687"
	instance_tye			= "t2.micro"
	availability_zone		= "ap-south-1a"
	key_name				= "jenkins-key"
	vpc_security_group_ids	= [aws_security_group.sd_grp.id]

provisioner "remote-exe" {
	inline = [
		"sudo yum update –y",
		"sudo amazon-linux-extras install ansible2 -y",
		]
}

connection {
	type		= "ssh"
	host		= self.public_ip
	user		= "ec2-user"
	private_key	= file("./jenkins-key.pem")
 }
 	tags = {
 	Name = "Ansible-Server"
 	}
}