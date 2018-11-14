# Rancher
Everything you need to deploy a Rancher cluster for managing Kubernetes. Additionally, the **/dashboard** directory assists you in setting up the Kubernetes dashboard and the **/eks** directory provides a walkthrough in setting up an AWS EKS cluster through the Rancher UI.

![alt text](https://i.imgur.com/3BLM0Tb.jpg "Giddyup!")

#### Getting started:
To deploy Rancher, there a few prerequisites required. First, you need an AWS access/secret key profile on the machine you're running Terraform from. This configuration is compatible with a typical [AWS SDK](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html "Setup AWS credentials") setup:
1. Create an AWS credentials file at **~/.aws/credentials**
2. Create AWS access/secret key profiles in the new file by adding your information in this format:
```
[development]
aws_access_key_id=XXXXXXXX
aws_secret_access_key=XXXXXXXX
[production]
aws_access_key_id=XXXXXXXX
aws_secret_access_key=XXXXXXXX
```
3. Add the [terraform binary](https://www.terraform.io/downloads.html "Download Terraform") to your PATH
4. Add the [kubectl binary](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-using-curl "Download kubectl") to your PATH
5. Add the [helm binary](https://github.com/helm/helm/releases "Download Helm") to your PATH
5. Add the [rke binary](https://github.com/rancher/rke/releases "Download RKE") to your PATH

Finally, from your Terraform running directory (for this project it is the `install` directory), run:
```
$ terraform init
```

This will install all of the required plugins to run the Rancher module.

#### SSH Requirements:
In order to run the rancher install script properly, you will need initial SSH access to the
servers and you will need the private key added to your **ssh-agent**.

#### Terraform Variables:
These variables are typically stored in an .environment.tfvars file (ex: .development.tfvars) but defaults can be modified in the variables.tf file. If this module is ran in conjunction with another Terraform module that's creating a VPC or subnets, the variable values can be replaced with interpolations.

#### Running Terraform:
Make sure you're running in the [workspace](https://www.terraform.io/docs/state/workspaces.html "Terraform workspaces") you intend to deploy to. It is recommended that you run **terraform workspace new environment (ex: dev)** to create a workspace per environment you plan on provisioning to. This isolates the [state](https://www.terraform.io/docs/state "Terraform state") of your Terraform so that your deployment isn't clashing with multiple environments.

Next run:
```
$ terraform plan --var-file=environment.tfvars (ex: .development.tfvars)
```
Confirm that you're not modifying a running cluster (unless that is the intent) and that your expected changes are displayed. If you just edited the **variables.tf** file to change the defaults, you do not need to run a **--var-file=** override.


Finally, run:
```
$ terraform apply -var-file=environment.tfvars
```
This will provision all of the nodes, load balancers, and DNS records that your Rancher cluster will run on.

#### Provisioning the Rancher cluster:

```
$ cd install
$ ./rancher-install
```

Eventually, you will be prompted for the hostname and you should name it like **rancher.example.com**
ex:
```
...
Please enter the hostname you would like to name your Rancher cluster
rancher.dev.bensapp.com
You entered rancher.dev.bensapp.com. Is this correct? yes
Yeehaw!
...
```

From there, you should be able to navigate to **rancher.example.com**. However, it may take a couple of moments for the Kubernetes ingress to finish provisioning, as well as the Let's Encrypt cert to validate. After that, you'll be prompted to create a new admin password for the new cluster.


#### Destroying the stack:
From the [workspace](https://www.terraform.io/docs/state/workspaces.html "Terraform workspaces") you ran the **terraform apply** in, run:
```
$ terraform destroy --var-file=environment.tfvars (ex: .development.tfvars)
```
If you used the default **variables.tf** file, you can omit the **--var-file** override.
NOTE: If you created a Kubernetes cluster with this Rancher deployment, destroying the Rancher cluster will not destroy the Kubernetes cluster you created.
