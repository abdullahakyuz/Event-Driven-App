#! /bin/bash
apt-get update -y
apt-get upgrade -y
hostnamectl set-hostname kube-master
apt-get update -y
apt-get install -y openjdk-17-jdk wget net-tools
KAFKA_VERSION="3.6.0"
SCALA_VERSION="2.13"
KAFKA_HOME="/usr/local/kafka"
mkdir -p $KAFKA_HOME
mkdir -p /usr/local/kafka/data/zookeeper
mkdir -p /usr/local/kafka/data/kafka
wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O /tmp/kafka.tgz
tar -xvzf /tmp/kafka.tgz -C /usr/local
mv /usr/local/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/* $KAFKA_HOME
rm -rf /tmp/kafka.tgz
echo "dataDir=/usr/local/kafka/data/zookeeper" > $KAFKA_HOME/config/zookeeper.properties
# Kafka Broker Yapılandırması
    sed -i "s|log.dirs=/tmp/kafka-logs|log.dirs=/usr/local/kafka/data/kafka|g" $KAFKA_HOME/config/server.properties

    # Zookeeper ve Kafka Servislerini Başlatma
    nohup $KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties > /var/log/zookeeper.log 2>&1 &
    nohup $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties > /var/log/kafka.log 2>&1 &

    # Zookeeper ve Kafka'nın Başarıyla Yüklendiğini Kontrol Etme
    sleep 10
    netstat -plnt | grep -E "2181|9092"
npm install
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl kubernetes-cni docker.io
apt-mark hold kubelet kubeadm kubectl
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu
newgrp docker
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sysctl --system
mkdir /etc/containerd
containerd config default | tee /etc/containerd/config.toml >/dev/null 2>&1
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd
kubeadm config images pull
kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=All
mkdir -p /home/ubuntu/.kube
cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
chown ubuntu:ubuntu /home/ubuntu/.kube/config
su - ubuntu -c 'kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml'
su - ubuntu -c 'kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.26/deploy/local-path-storage.yaml'
sudo -i -u ubuntu kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'