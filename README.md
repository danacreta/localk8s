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
2. run `install_requirements.sh` to prepare your env
3. create a folder `my_app_name` in `local_k8s/apps` folder. You can add here a Dockerfile and a deployment.yml for your app OR
4. set variables in config.yml file. Check their description <a href="#variables-description">here</a>
5. run the script `local_k8s.sh` with one of the parameters: `create_cluster | deploy_application | destroy_cluster`
- `./local_k8s.sh create_cluster` - checks and starts minikube
- `./local_k8s.sh deploy_application` - deploy your application using your files in spps folder or variables you've mentioned in `config.yml`
- `./local_k8s.sh destroy_cluster` - destroys the cluster

### What we have
In the `local_k8s` folder we have:
 - `config.yml` - config file
 - `install_requirements.sh` - install apps needed
 - `./local_k8s.sh` - script for creating/destroing cluster / deploy app(s)
 - folder `k8s` - ansible playbooks for local_k8s script actions and also `include/` folder with included tasks in plybooks
 - folder `apps` - user can add a subfolder for each app to be deployed. Each folder app should have the same name as variable `deploys.name` in config (mandatory).
   It can contain a `deployment.yml` file. In this case we will use this file for deployment of this app. For consistency, the user should add in config the namespace used in his file and image/s info - Not yet fully tested
   It can also contain a Dockerfile for creating the image to be used in container. It is not yet finalized this feature - we will need subfolders with Dockerfile for each container. In case the image/s setted in config are not available at the run time, we try to build the image using these Dockerfiles.
   
### How it works
Creating a deployment
   - check the cluster status. If everything is fine we try to deploy.
   - check namespace (config: env.namespace) exists. Otherwise we create it
   - for each item in config: deploys list we deploy an app. For each app to be deploy we do the following:
      - First, we check all images in the list config: deploys[i].engine. If it doesn't exists locally we look for a Dockerfile in the apps/myapp/ folder. If this file does not exists, we check the config var deploys[i].engine[j].file_path. After we decided for the path of the Dockerfile, we build the image. In the same time, for each image we add the needed container info for deploing it later to kubernetes.
      - Then we check if a deployment file exists in the apps/myapp/ folder. In this case we use this for deployment. Otherwise, we buid our own specification for app and service based on config variables.
     

## Variables Description
|                	| Variable   	| Choises/Defaults        	| Mandatory 	| Description                                               	|
|----------------	|------------	|-------------------------	|-----------	|-----------------------------------------------------------	|
| env            	|            	|                         	|           	| global variables                                          	|
|                	| local_kube 	| minikube(\*k3d)/minikube | yes       	| local Kubernetes                                          	|
|                	| engine     	| docker(\*podman/docker)  | yes       	| container engine to be used                               	|
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
- better error messages
