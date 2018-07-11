## Dev Setup
Make sure you have the following installed:
- Python3 with package requests (pip3 install requests)
- gcloud command line tools - gcloud auth setup 
- 

## Setup Kubernetes cluster
Setup your gcp auth from local terminal using the steps explained here:
https://cloud.google.com/sdk/gcloud/reference/auth/ 

The cluster will be setup using Terraform. Once it is setup connect to your kube cluster from your local terminal (example):

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
