# Deliver Terraform Code

Create a Helm repository using Azure Blob Storage (search on the internet for instructions) The Azure Blob Storage should be created using Terraform.

Once the bucket is ready, push some example charts into the repository You will find on the internet Helm s3 plugins that help interact with s3 as a Helm repository.

## Documentation

### Install the Azure CLI tool
You will use the Azure CLI tool to authenticate with Azure.
#### For windows
```
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
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

### Install Terraform
To install Terraform, find the [appropriate package](https://developer.hashicorp.com/terraform/install) for your system and download it as a zip archive.

After downloading Terraform, unzip the package. Terraform runs as a single binary named terraform. Any other files in the package can be safely removed and Terraform will still function.

Finally, make sure that the terraform binary is available on your PATH. This process will differ depending on your operating system.

[This Stack Overflow article](https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows) contains instructions for setting the PATH on Windows through the user interface

### Verify the installation
Verify that the installation worked by opening a new terminal session and listing Terraform's available subcommands.
```
terraform -help
```

### Initialize your Terraform configuration
Initialize your directory in your terminal. The terraform commands will work with any operating system. 
```
terraform init
```

### Format and validate the configuration
We recommend using consistent formatting in all of your configuration files. The terraform fmt command automatically updates configurations in the current directory for readability and consistency.

Format your configuration. Terraform will print out the names of the files it modified, if any. In this case, your configuration file was already formatted correctly, so Terraform won't return any file names.
```
terraform fmt
```
You can also make sure your configuration is syntactically valid and internally consistent by using the terraform validate command.
```
terraform validate
```

### Apply your Terraform Configuration
Run the terraform apply command to apply your configuration.

This output shows the execution plan and will prompt you for approval before proceeding. If anything in the plan seems incorrect or dangerous, it is safe to abort here with no changes made to your infrastructure. Type yes at the confirmation prompt to proceed.
```
terraform apply
```

### Inspect your state
When you apply your configuration, Terraform writes data into a file called terraform.tfstate. This file contains the IDs and properties of the resources Terraform created so that it can manage or destroy those resources going forward. Your state file contains all of the data in your configuration and could also contain sensitive values in plaintext, so do not share it or check it in to source control.
```
terraform show
```