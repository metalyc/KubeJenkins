sudo apt-get update
sudo apt-get install -y openjdk-11-jdk
sudo java -version

sudo apt-get install -y apt-transport-https
sudo apt-get install -y ca-certificates
sudo apt-get install -y curl
sudo apt-get install -y gnupg
sudo apt-get install -y openssh-server
sudo apt-get install -y git
sudo apt-get install -y iptables

sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FCEF32E745F2C3D5
sudo apt-get update
sudo apt-get install -y jenkins
sudo mkdir /example-web
sudo mkdir -p /var/lib/jenkins/.ssh/
sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo mkdir -p /jenkins
sudo chown -R jenkins:jenkins /jenkins
sudo runuser -l jenkins -c 'ssh-keygen -q -b 2048 -t rsa -f /var/lib/jenkins/.ssh/id_rsa -N ""'
sudo runuser -l jenkins -c 'git ls-remote -h https://github.com/metalyc/web-example.git HEAD'

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu (lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

service jenkins start
tail -F /var/lib/jenkins/secrets/initialAdminPassword
