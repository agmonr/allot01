# Demo project for Allot - creating a Kubernetes with "Hello World"

## General
This project is using bash scripts to deploy "hello world" docker on Kubernetes cluster.

## Steps
1. Deploying Kuberntes on aws (eks)
2. Auto configure local managment tools (kubectl)
3. Deploy and configure helm.
4. Deploy Calico.
5. Create docker images, upload it to amazon registry (ecr) and deploy it on the cluster. 

## Folder Structre
/bin        -> The bash scripts.
/terraform  -> Terraform files to create eks.
/docer      -> Docker file based on nginx with custom html
/deploy     -> yaml files for creating a service and a deployment.

## Scripts
01_terraform_create_eks.sh  -> init, plan and apply terraform dsl for eks.  
02_ecr_build_push.sh        -> Bulding docker file and copy index.html.
03_eks_enable_helm.sh       -> Some eks settings for the helm user and deploy helm.
04_calico_deploy.sh         -> Deploy Calico to enable better network isolation and ipv6.
05_kubectl_deploy_demo.sh   -> Deploy the docker images from ecr to eks. The scripts is using a template to get the current ecr uri.

Each scrips can be run localy or by a pipe line jenkin file/other ci/cd tools.

## Eks Properties
name: demo
networks: 1 vpc, 2 subnets with ipv6 on 2 availity zones.
          ingress connection to the api.
working nodes: 2 working nodes (demo1, demo2)
          

## Todo
* manage versions for docker images
* Add ssl for incoming traffic.
* Test for each step.
* Create pipeline scripts to run/replace the bash scripts.
* Check prerequisites and software version.
* Remove hardcoded settings and use envirement variables. (aws region, etc)
* Better output from the scripts. 
* Create common file for global variables.


## Plase make sure you have the latest version of kubectl, terraform and helm installed and in your path.
#
Terraform is based on:
https://aws.amazon.com/blogs/startups/from-zero-to-eks-with-terraform-and-helm/

# fun
use:
pandoc -f markdown README.md > docker/html/index.html 
to update the docker html file 
