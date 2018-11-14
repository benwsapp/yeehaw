# Creating an EKS cluster via Rancher
How to provision an EKS cluster with the Rancher UI

#### Requirements:
An AWS IAM user needs elevated/administrative permissions to create an EKS cluster. For more information on permissions required, as well as Rancher's official docs on setting up an EKS cluster, visit [here](https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/hosted-kubernetes-clusters/eks/ "Seting up an EKS cluster with Rancher").

#### Navigating the Rancher UI to create a cluster

1. In the Rancher UI, under the **Global** context, select **Clusters**.
2. On the **Clusters** page, select **Add Cluster**.
3. Select **Amazon EKS** as your Kubernetes hosted provider.
![alt text](https://i.imgur.com/pGM1vAU.png "EKS")
4. Name your cluster in the **Cluster Name** field.
![alt text](https://i.imgur.com/PwA96Im.png "Cluster Name")
5. Under **Member Roles**, select what users you've added to your cluster will have access to the cluster and with what permissions.
6. In the **Account Access** field, select the region you'd like to deploy the cluster to and input your AWS Access/Secret key pair.
![alt text](https://i.imgur.com/re20JD3.png "Account Access")
7. Next, for **Service Role**, select **Standard: Rancher generated service role**.
![alt text](https://i.imgur.com/p2NfpFt.png "Service Roles")
8. For **VPC and Subnet**, leave **Public IP for Worker Nodes** as **Yes** and select **Custom: Choose from your existing VPC and Subnets** for **VPC and Subnet**. For the subnets, select the subnets created for this cluster via the VPC Terraform module.
![alt text](https://i.imgur.com/1p7XT31.png "VPC and Subnet")
9. For **Security Groups**, choose the security group created for this cluster.
10. Finally, for **Nodes**, select the type of node you want the EKS worker Autoscaling Group to use, the minimum number of nodes to be running at a time as well as the maximum number of nodes.
![alt text](https://i.imgur.com/9PHhUIU.png "Nodes")

Now, after you select **Create**, your cluster will begin provisioning and will be fully operational momentarily. Next, you can install the Kubernetes dashboard for the new cluster by following the instruction in the **/dashbard** directory.
