# AKS Mediawiki

- Deploy AKS cluster using terraform.
- Deploy Mediawiki workload on AKS using helm.

## Prerequisites

- Ubuntu linux server
- Access to Azure subscription

### Getting started:
=================

#### 1. Set Azure subscription
--------------------------------
- If doing interactively, we can execute azure cli command: az login
- For non interactive login, we need to create a service principal by following steps:
		az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
		Note down the credentials
		az login --service-principal --username APP_ID --password PASSWORD --tenant TENANT_ID

You can refer to this Microsoft document for more details: [Azure login using SP](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli#sign-in-using-a-service-principal "Azure login using SP")

#### 2. Clone the repo
----------------------------------------
		 git clone <repo url>

#### 3. Execute `deployment.sh` file
-------------------------------------------
	 ./deployment.sh

- This script runs the checks if all the required packages are available or not. if not available, it installs it.
- Invokes Terraform to provision an AKS cluster in your Azure subscription.
- Then deploys the mediawiki workload using helm.

#### 4. After completion, copy the endpoints to access the mediawiki website hosted in AKS
	 export SERVICE_IP=$(kubectl get svc --namespace default mediawiki --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
	 echo "Mediawiki URL: http://$SERVICE_IP/"

#### 5. Get your MediaWiki login credentials by running:
	echo Username: user
	echo Password: $(kubectl get secret --namespace default mediawiki -o jsonpath="{.data.mediawiki-password}" | base64 --decode)

### Common problems faced (Till now):
-----------------------------------
- ##### Loadbalancer External IP is taking more time to populate:
		The most common reason for this would be, if your AKS cluster has access to create Loadbalancer public ip or not
		 Check `kubectl describe svc <mediawiki svc name>`
		 Check `kubectl get events` to see events logs and notice the error.
		 Check if there is any organization policy that is blocking the creation of a public IP.
		 Check what role or permission you have over the subscription.

### Things to improve
------------------------------
- Use external database instead of hosting database in AKS cluster itself. This helps in following:
  - Built-in high availability
  - Scale as needed
  - Secured since data is encrypted while resting and in motion
  - Automatic backups and point-in-time restore
