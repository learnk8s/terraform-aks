# Getting started with Terraform and Kubernetes on Azure AKS

Playground to learn Terraform on Azure and provision an AKS cluster in one command.

You can find the [full tutorial on the Learnk8s blog](https://learnk8s.io/blog/get-start-terraform-aks/).

## Getting started

Install the Azure CLI.

You can find detailed [instructions on how to install it on the official website](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).

> [Sign up for an Azure account](https://azure.microsoft.com/en-us/free/), if you don't own one already. You will receive USD200 in free credits.

You can link your Azure CLI to your account with:

```terminal|command=1|title=bash
az login
```

And you can list your accounts with:

```terminal|command=1|title=bash
az account list
```

**Make a note now of your subscription id.**

> If you have more than one subscription, you can set your active subscription with `az account set --subscription="SUBSCRIPTION_ID"`. You still need to make a note of your subscription id.

Create the Service Principal with:

```terminal|command=1-3|title=bash
az ad sp create-for-rbac \
  --role="Contributor" \
  --scopes="/subscriptions/SUBSCRIPTION_ID"
```

The previous command should print a JSON payload like this:

```json
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
```

Make a note of the `appId`, `password` and `tenant`.

Export the following environment variables:

```terminal|command=1,2,3,4|title=bash
export ARM_CLIENT_ID=<insert the appId from above>
export ARM_SUBSCRIPTION_ID=<insert your subscription id>
export ARM_TENANT_ID=<insert the tenant from above>
export ARM_CLIENT_SECRET=<insert the password from above>
```

You should be able to provision the cluster in Terraform.

Change your current directory to:

- <01-getting-started>
- <02-aks>
- <03-aks-helm>
- <04-templated>

to start provisioning your infrastructure with Terraform.