# Provisioning an Azure Kubernetes Service (AKS) cluster linked to a private Azure Container Registry (ACR)

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

You can log to the private registry with:

```bash
docker login <registry url>
```

The registry URL, username and password are visible in the Terraform output.

You can push an sample container image to the cluster as follows:

```bash
docker pull busybox
docker tag busybox uniquenameregistry1.azurecr.io/busybox
docker push uniquenameregistry1.azurecr.io/busybox
```

You can test that AKS can pull the image from a private registry with:

```bash
kubectl run test -ti --rm \
  --image=uniquenameregistry1.azurecr.io/busybox \
  --restart=Never
```

You should have shell access to the container.