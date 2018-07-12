# Autoscaling Kong Gateway on Kubernetes Showcase

## Dev Setup

Make sure you have the following installed:

- gcloud command line tools - gcloud auth setup
    - this is optional, alternatively you can access the cluster from Google cloud console
- terraform 
- Python3 with package requests (pip3 install requests) for load testing 

## Setup Kubernetes cluster -  Using Terraform

Make sure you have the service account json file to access the various resources on GCP via the service account. Save the file as key.json under the credentials folder (create this folder).

First setup the bucket which saves the terraform state files (please note this bucket is likely already setup):
cd into the bucket-setup folder

```bash
terraform init
terraform plan
```

Check to see if the bucket is already there and what new resources will be used then if you are fine with it:

```bash
terraform apply
```

After the bucket has been setup cd into the kube-cluster folder then repeat the above commands to deploy the cluster:

```bash
terraform init
terraform plan
terraform apply
```

Can check the GCP Console under kubernetes engine to see if your cluster is up and running.

## Destroy cluster

To destroy the cluster run: 

```bash
terraform plan -destroy
```

After checking if the destroyed resources are ok run:

```bash
terraform destroy
```

### Connect to Kube Cluster from GCP Console

Connecting to your kube cluster directly from gcp cloud console is the easiest way. Use the GCP console navigate to google kubernetes engines page then click connect from your kong-cluster and then press connect using cloud console. Then you should be able to use kubectl commands. 

### Connet to Kube Cluster from local terminal

Setup your gcp auth from local terminal using the steps explained here:

https://cloud.google.com/sdk/gcloud/reference/auth/ 

Once it is setup navigate to gcp console under the google kubernetes engine page and press connect on your kong-cluster. Copy and paste the connection string to your local terminal in the form such as:

```bash
gcloud container clusters get-credentials cluster-1 --zone australia-southeast1-a --project kubeproj123
```

## Setup Kong

```bash
kubectl apply -f cassandra.yaml
kubectl apply -f kong_migration_cassandra.yml
```

Then watch for migration completion by using:

```bash
kubectl get hpa --watch
```

Wait for a few minutes until both state changes to 1. 
Then deploy kong:

```bash
kubectl apply -f kong_cassandra.yaml
```

Delete finished migration job using:

```bash
kubectl delete job kong-migration
```

## Autoscaling

Cluster has been setup with pod autoscaling and node autoscaling. What that means is kong is setup so that it can scale if usage surges. For production make sure to setup liveness and readiness probes and pod disruption budget so as to not disrupt users when pod is unavailable.


## Other Considerations

For proper deployments please edit kong_cassandra.yaml file to only allow the correct IP range for all services and not just 0.0.0.0/0 especially for admin endpoints. For deploying kubernetes may need to add master auth CIDR ranges. 

## Load testing

Using the simple python script call the kong-proxy external endpoint and watch for the horizontal pod autoscaler scale. Make sure the edit the kong_cassandra.yaml file as below:

```bash
targetAverageUtilization: 50 > targetAverageUtilization: 1
```

this is so that the pods will scale otherwise it will never reach 50% of utilisation. Apply this change to your kube cluster

```bash
kubectl apply -f kong_cassandra.yaml
```

Run the python script in another terminal to simulate load

```bash
python3 load-testing.py
```

Then watch the horizontal pod autoscaler and after a few minutes it should scale multiple pods.

```bash
kubectl get hpa --watch
```
