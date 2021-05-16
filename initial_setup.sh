#!/bin/bash

install_terraform(){
	sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
	sudo apt-get update && sudo apt-get install terraform
}

install_azurecli(){
	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

install_helm(){
	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
	chmod 700 get_helm.sh
	./get_helm.sh
}

install_kubectl(){
	sudo apt-get update
	sudo apt-get install -y apt-transport-https ca-certificates curl
	sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
	echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl
}

terraform -help > /dev/null

VALUE=$(echo $?)

if [ $VALUE -eq 0 ]
then
	echo "Terraform is already installed"
else
	echo "Initializing Terraform installation"
	install_terraform
fi

az version > /dev/null

VALUE=$(echo $?)

if [ $VALUE -eq 0 ]
then
        echo "Azure CLI is already installed"
else
        echo "Initializing Azure CLI installation"
        install_azurecli
fi

helm version > /dev/null

VALUE=$(echo $?)

if [ $VALUE -eq 0 ]
then
        echo "Helm is already installed"
else
        echo "Initializing Helm installation"
        install_helm
fi

kubectl > /dev/null

VALUE=$(echo $?)

if [ $VALUE -eq 0 ]
then
        echo "kubectl is already installed"
else
        echo "Initializing kubectl installation"
        install_kubectl
fi

