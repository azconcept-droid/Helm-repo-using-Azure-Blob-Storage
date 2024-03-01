# Deliver Terraform Code

Create a Helm repository using Azure Blob Storage (search on the internet for instructions) The Azure Blob Storage should be created using Terraform.

Once the bucket is ready, push some example charts into the repository You will find on the internet Helm s3 plugins that help interact with s3 as a Helm repository.

## Prerequisites
- Install azure cloud cli [here](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- Install terraform [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Create an azure cloud account [here](https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwjSrZb2rNOEAxVlk1AGHWdxCckYABACGgJkZw&gclid=CjwKCAiAloavBhBOEiwAbtAJO8LtpuZjfweWojd-eHtBPMrAdbjM3K-y2hY9t8k6WXgvgfcC1cChixoCzpsQAvD_BwE&ohost=www.google.com&cid=CAESVuD2J0kdkfnkQONvPZrxuVWrYEmSU2S76tW2UCFncdl7Una0SJosngkz9dNbmkU1CkhyyXGiz6dYm7F2EOfZG-eRRLvS-TeEj73Rq-Nmlho9rnlyV9es&sig=AOD64_32oTyoiSZDTMT-5vs4UxNMexuILA&q&adurl&ved=2ahUKEwjagZH2rNOEAxUfQEEAHXytAf4Q0Qx6BAgLEAE)

## Usage
### Fork or Clone this repo
```
git clone https://github.com/azconcept-droid/Helm-repo-using-Azure-Blob-Storage.git
```
### Authenticate using the Azure CLI
Terraform must authenticate to Azure to create infrastructure.

In your terminal, use the Azure CLI tool to setup your account permissions locally.
```
az login
```
Your browser will open and prompt you to enter your Azure login credentials. After successful authentication, your terminal will display your subscription information like this 👇.

>You have logged in. Now let us find all the subscriptions to which you have access...
>
>[  
>  {  
>    "cloudName": "AzureCloud",  
>    "homeTenantId": "0envbwi39-home-Tenant-Id",  
>    "id": "35akss-subscription-id",  
>    "isDefault": true,  
>    "managedByTenants": [],  
>    "name": "Subscription-Name",  
>    "state": "Enabled",  
>    "tenantId": "0envbwi39-TenantId",  
>    "user": {  
>      "name": "your-username@domain.com",  
>      "type": "user"  
>    }  
>  }  
>]

Find the id column for the subscription account you want to use.

Once you have chosen the account subscription ID, set the account with the Azure CLI.

```
az account set --subscription "35akss-subscription-id"
```

### Create a Service Principal
Next, create a Service Principal. A Service Principal is an application within Azure Active Directory with the authentication tokens Terraform needs to perform actions on your behalf. Update the <SUBSCRIPTION_ID> with the subscription ID you specified in the previous step.
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```
### Set your environment variables
HashiCorp recommends setting these values as environment variables rather than saving them in your Terraform configuration as best practice ✔.

> For windows  
> $Env:ARM_CLIENT_ID = "<APPID_VALUE>"  
> $Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"  
> $Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"  
> $Env:ARM_TENANT_ID = "<TENANT_VALUE>"  

> For linux  
> export ARM_CLIENT_ID="<APPID_VALUE>"  
> export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"  
> export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"  
> export ARM_TENANT_ID="<TENANT_VALUE>"  

2. Initialize terraform
```
terraform init
```
3. Plan the terraform deployment
```
terraform plan
```
4. Apply the terraform plan
```
terraform apply
```
