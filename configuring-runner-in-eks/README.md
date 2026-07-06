I configured GitHub Actions Self-Hosted runner in eks cluster

I learnt it initially from the following video tutorials:
https://www.youtube.com/watch?v=nrnMNre9v3A

I set up the runner in my eks following the same tutorial and the
following repo as provided in the description:
https://github.com/mathisve/github-actions-runners-k8s.git

First I create a GitHub PAT as fine-grained

I installed ARC Controller with:
helm install arc \
--namespace "arc-systems" \
--create-namespace \
oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

Then deployed runner scale set with:
helm install "arc-runner-set" \
--namespace "arc-runners" \
--create-namespace \
--set githubConfigUrl="https://github.com/Ashir-Qayyum/sensiply-training-eks-terraform-poc" \
--set githubConfigSecret.github_token="PAT_I_Just_Generated" \
oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set


THen for testing, i created a test.yaml file:
name: Test Runner

on:
  push:

jobs:
  test:
    runs-on: arc-runner-set

    steps:
      - uses: actions/checkout@v4

      - name: Test
        run: |
          echo "Helloo From EKS runner!!"
          hostname


Then FINALLY test push to verify working!!!


And watched runner pod being created i the cluster:
kubectl get pods -n arc-runners
