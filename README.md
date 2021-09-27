# localk8s

local Kubernetes environment, so developers can test their application deployments before deploying to the development environment

## Installation

### What you need:
- 2 CPUs or more
- 2GB of free memory
- 20GB of free disk space
- Internet connection
- just Ubuntu for now
- Container or virtual machine manager - Docker (just Docker for now) 
    * We assume that the developer is using ubuntu with docker allready installed and in the root folder of the project a Dockerfile exists.
- minikube - https://minikube.sigs.k8s.io/docs/start/
- kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
- ansible-playbook - https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html with plugin `community.kubernetes.k8s` (https://docs.ansible.com/ansible/latest/collections/community/kubernetes/k8s_module.html)

Some of the above have their specific requirements, so please check their installation guides.

### Make it work
1. get the `localk8s` from git:
    `git pull https://github.com/danacreta/localk8s`
2. copy the new created folder to your dev project homefolder
    `cp -r localk8s myProjectFolder`
3. edit `config.yml` file. You can change `k8s` parameters in there or leave them as they are. It is mandatory to set the `docker` parameters.
```
docker:
  image_name: 
  image_tag: 

k8s:
  name: local8s-dev
  namespace: local8s-dev

```
4. run the script `local_k8s.sh` with one of the parameters: `create_cluster | deploy_application | destroy_cluster`
- `./local_k8s.sh create_cluster` - checks and starts minikube
- `./local_k8s.sh deploy_application` - deploy your application using minikube and docker image you've mentioned in `config.yml`
- `./local_k8s.sh destroy_cluster` - destroys the deployment and service
