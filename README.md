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
    * Check docker installation here: https://docs.docker.com/engine/install/ubuntu/
- minikube - https://minikube.sigs.k8s.io/docs/start/
- kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
- ansible-playbook - https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html with plugin `community.kubernetes.k8s` (https://docs.ansible.com/ansible/latest/collections/community/kubernetes/k8s_module.html)

Some of the above have their specific requirements, so please check their installation guides.
You can also use `install_requirements.sh` script from this repository.

### Make it work
1. get the `localk8s` from this git repository
   `git clone https://github.com/danacreta/localk8s`
2. create a folder `my_app_name` in `local_k8s/apps` folder. You can add here a Dockerfile and a deployment.yml for your app OR
3. set variables in config.yml file
4. run the script `local_k8s.sh` with one of the parameters: `create_cluster | deploy_application | destroy_cluster`
- `./local_k8s.sh create_cluster` - checks and starts minikube
- `./local_k8s.sh deploy_application` - deploy your application using your files in spps folder or variables you've mentioned in `config.yml`
- `./local_k8s.sh destroy_cluster` - destroys the cluster

# Variables Description
|                	| Variable   	| Choises/Defaults        	| Mandatory 	| Description                                               	|
|----------------	|------------	|-------------------------	|-----------	|-----------------------------------------------------------	|
| env            	|            	|                         	|           	| global variables                                          	|
|                	| local_kube 	| minikube(\*k3d)/minikube 	| yes       	| local Kubernetes                                          	|
|                	| engine     	| docker(\*podman/docker)  	| yes       	| container engine to be used                               	|
|                	| namespace  	| any/default             	| yes       	| namespace to be used for deployment                       	|
| deploys        	|            	|                         	|           	| list of apps to be deployed                               	|
|                	| name       	| any                     	| yes       	| name of deployment. Used for app name, service name       	|
|                	| replicas   	| min 1/3                 	| yes       	|                                                           	|
|                	| port       	| any/80                  	| yes       	| service port. Not yet functional. We might need a list    	|
| deploys.engine 	|            	|                         	|           	| A list of vars for multiple containers used in deployment 	|
|                	| image_name 	| any                     	| yes       	|                                                           	|
|                	| image_tag  	| any                     	| yes       	|                                                           	|
|                	| file_path  	| any                     	| no        	| path to Dockerfile if we have to build the image          	|
|                	| port       	| any/80                  	| yes       	| containerPort                                             	|
\* to be added

### TODO
- in install script check for docker installation and install it if it's not there
- add the possibility fr minikube to work with podman ?
- add the option to use something else insted of minikube ( like k3d ? )
