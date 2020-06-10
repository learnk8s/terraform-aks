# Provisioning an Azure Kubernetes Service (AKS) cluster

You can preview the changes with:

```bash
terraform plan
```

You can apply the changes with:

```bash
terraform apply
```

Once provisioned, you can export the kubeconfig with:

```bash
echo "$(terraform output kube_config)" > azurek8s
```

You can add the credentials to your kubeconfig or temporarily use the file as your kubeconfig with:

```bash
export KUBECONFIG="${PWD}/azurek8s"
```

You can verify that you can connect to the cluster with:

```bash
kubectl get nodes
```