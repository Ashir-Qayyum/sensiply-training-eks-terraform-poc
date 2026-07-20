I configured GitHub Actions Self-Hosted runner in my EKS cluster

I learnt the configuration initially from the following video tutorial:
https://www.youtube.com/watch?v=nrnMNre9v3A
, And the repository provided in the Description:
https://github.com/mathisve/github-actions-runners-k8s.git

GitHub has published its official Helm Chart supporting Self-hosted
Runner in the Kubernetes Cluster called ARC (Action Runner Controller)

WORKFLOW:

First, we deply the arc controller & listener in the namespace 'arc-systems'
using the ARC Helm Chart. And Runner Scale Set in the namespace 'arc-runners'.
The Listener watches for the Repository it is connected
to, and on the workflow trigger, it  signals the Controller.
The Controller Schedules the Job on the runner scale set installed in the 
'arc-runners' namespace. It lauches runner pod in the arc-runners namespace, where
the job is executed. Once the job execution is completed, the runner pods are terminated.

IMPLEMENTATION:

First I created a fine-grained GitHub Personal Access Token PAT for the workflow

Then, I installed arc controllers creating the namespace arc-systems
using official helm chart by GitHub

(with connected with the EKS Cluster)

>  helm install arc \
>   --namespace "arc-systems" \
>   --create-namespace \
>   oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

Finally, I deployed runner scale set with:

> helm install "arc-runner-set" \
>   --namespace "arc-runners" \
>   --create-namespace \
>   --set githubConfigUrl="https://github.com/Ashir-Qayyum/sensiply-training-eks-terraform-poc" \
>   --set githubConfigSecret.github_token="PAT_I_Just_Generated" \
>   --set containerMode.type=dind \
>   oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set

(I also ran Docker-in-Docker Sidecar container inside the runner pod. In order to build the 
image, the runner needs Docker Daemon to build image using Docker CLI. DinD Sidecar Container
shares the docker.sock through the shared volume to the runner container providing docker daemon such that 
It can build the image)

I successfully executed my CI/CD Workflow for the SMS Application on the Runner.

EXECUTION DEMO:

Installing & Observing the Action Controller Runner:
![screenshots/image 01.png](<../screenshots/image 01.png>)

Pushing the Code to GitHub:
![screenshots/image 02.png](<../screenshots/image 02.png>)

Backend Job Started:
![screenshots/image 03.png](<../screenshots/image 03.png>)

Runner Pods Launched for Backend:
![screenshots/image 04.png](<../screenshots/image 04.png>)

When the Backend Job Execution Completed, the runner pod terminated:
![screenshots/image 05.png](<../screenshots/image 05.png>)

Then, the Frontend Job Started:
![screenshots/image 06.png](<../screenshots/image 06.png>)

The new runner Pod launched for Frontend Job:
![screenshots/image 07.png](<../screenshots/image 07.png>)

WHen the Frontend Job Execution Completion, the runner pod terminated:
![screenshots/image 08.png](<../screenshots/image 08.png>)

Finally, the Deploy Job Started:
![screenshots/image 09.png](<../screenshots/image 09.png>)

The new Runner was launched for Deploy Job:
![screenshots/image 10.png](<../screenshots/image 10.png>)

When the Deploy Job was completely executed, the runner pod terminated:
![screenshots/image 11.png](<../screenshots/image 11.png>)


FINNALY, THE APPLICATION STACKS WEREE DEPLOYED IN THE SMS NAMESPACE WITH BACKEND, & FRONTEND
(DATABASE IS CONFIGURED IN RDS MYSQL):
![screenshots/image 12.png](<../screenshots/image 12.png>)


Accessing the SMS Frontend using public dns url in the browser (as I deployed the frontend svc with Type LoadBalancer):
![screenshots/image 13.png](<../screenshots/image 13.png>)
