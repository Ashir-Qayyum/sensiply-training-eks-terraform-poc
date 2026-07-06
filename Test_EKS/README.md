## I simply applied it with
## kubectl apply -f ngix-test-deploy-k8s.yaml

## then get the loadbalancer DNS with
## kubectl get svc

## Then access it in the browser with
## http://ad77cc907f9514b70b1e5ac2d9ccc712-858592786.us-east-1.elb.amazonaws.com
## (as I received this URL as the external IP for the deployment)