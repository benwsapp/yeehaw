# Kubernetes Dashboard in Rancher
How to provision and access the Kubernetes dashboard through Rancher

#### Requirements:

1. Once the Rancher cluster is built, go to the **Catalogs** tab and enable the **Helm Stable** catalog library. This adds all of the stable [helm charts](https://github.com/helm/charts "helm charts") to the Rancher catalog.
2. Next, select the cluster you want to provision the Kubernetes dashboard for (local, if it's a brand new Rancher cluster) and click the **Catalog Apps** tab, followed by the **Launch** button.
3. First, search for the **heapster** catalog and click the hyperlink.
4. In the **Namespace** section, where is says "This application will be deployed into the heapster namespace", select **Customize**.
5. Click the **Use an existing namespace** button and select the **kube-system** namespace from the dropdown.
6. In the **Answers** space, click the minus symbol, as no additional environment variables are needed.
7. Click **Launch**.
8. Repeat steps 3-7 but replace heapster with **kubernetes-dashboard**.

GUIs are exhausting.


#### Installing Dashboard Admin role

1. In the Rancher UI, navigate to the cluster you want to install the dashboard into and click the **Kubeconfig File** button.
2. In the prompt, select **Copy to Clipboard**
3. Navigate to the **/dashboard** directory (where you're at right now!) in your CLI
4. Create a **rancher.yml** file and paste the contents of your kubeconfig
5. Finally, run:
```
$ ./dashboard-install
```

This creates the cluster role for the Kubernetes dashboard to be accessible via Rancher as a proxy and outputs the address you'll access the Kubernetes dashboard from.

At this point, you should be able to browse to the Kubernetes dashboard for your cluster at the URL that's displayed when the dashboard-install command finishes.

Yeehaw!!
