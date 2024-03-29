apt-get update
apt-get install -y openjdk-11-jdk
java -version

apt-get install -y apt-transport-https
apt-get install -y ca-certificates
apt-get install -y curl
apt-get install -y gnupg
apt-get install -y openssh-server
apt-get install -y git
apt-get install -y iptables

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FCEF32E745F2C3D5
apt-get update
apt-get install -y jenkins
mkdir /example-web
mkdir -p /var/lib/jenkins/.ssh/
chown -R jenkins:jenkins /var/lib/jenkins
mkdir -p /jenkins
chown -R jenkins:jenkins /jenkins
runuser -l jenkins -c 'ssh-keygen -q -b 2048 -t rsa -f /var/lib/jenkins/.ssh/id_rsa -N ""'
runuser -l jenkins -c 'git ls-remote -h https://github.com/metalyc/web-example.git HEAD'

RUN wget -q https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.4.9-1_amd64.deb
RUN wget -q https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_20.10.9~3-0~ubuntu-focal_amd64.deb
RUN wget -q https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_20.10.9~3-0~ubuntu-focal_amd64.deb
RUN dpkg -i *.deb

curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

service jenkins start
tail -F /var/lib/jenkins/secrets/initialAdminPassword
