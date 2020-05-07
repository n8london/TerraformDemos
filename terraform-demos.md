# Terraform Demo Labs

This folder contains demonstrations of how to use some Terraform functions in your templates. Each folder is a self contained demonstration which you can run through with your customers to help explain these functions. Below are the guides on how to run each demonstrations. The intention is that these are run by someone who is familiar with Terraform and Azure, the labs assume you are already authenticated to the right Azure subscription. The three demos are;

1. Using the count function
1. Using the conditional expressions
1. Using the foreach loop

## Count Function

The count function is very useful for easily deploying multiple resources of the same type. For example, we may need a web farm and all the Virtual Machines need the same configuration, using the count function we can deploy the same resource multiple times and include the count number in the name. We can also use the count function when deploying the related resources NICs, IP addresses, disks etc. We can then easily change this number to scale up or down the number of resources deployed.

In our example we use Web Apps as they are quick to deploy. We will deploy one Application Service plan and as many Web Applications as determined by the count variable.

### Demo 1

1. Review the code in `\app-service-count-demo\variables.tf`
1. This is where we set the **webappcount** variable which is currently set to 1
1. Review the code in `\app-service-count-demo\main.tf`
1. Under resource **azurerm_app_service**
1. Here is where we set the count function referencing the **webappcount** variable
1. We include **count.index** in the name, this will iterate through the count and add a number to the resource name so each one is unique

        count               = var.webappcount
        name                = join("", [var.environment,"-WebApp-"count.index])

1. In a shell, make sure you are in folder `\app-service-count-demo\`
1. Run **terraform init**
1. Run **terraform plan**, check there are no errors
1. Run **terraform apply** and answer **yes**
1. Check the Azure Portal to review what has been deployed
   1. One App service Plan, one App service
1. Edit **variables.tf** and change change **webappcount** to **3**
1. Save the changes
1. Run **terraform plan**, check there are no errors
1. Run **terraform apply** and answer **yes**
1. Check the Azure Portal to review what has been deployed
   1. One App service Plan, three App services
1. **terraform destroy** to cleanup the resources
1. Check the resources have been deleted in the Azure Portal

## Conditional expressions

Conditional expressions can be used to dynamically omit or change an argument depending on a certain condition. This can be useful for several scenarios, one example may be that you create a module for deploying VMs and have a variable for VM size of small or large, you can set this as a variable and evaluate this variable to change configurations like SKU, disk size etc.

The example we will go through is a Public IP (PIP) deployment and associating this with a NIC depending on the value of a variable named 'public_ip'. The scenario could be that we are deploying VMs using a module or template and not all VMs will need a PIP. We have the variable 'public_ip' that is set to true or false and using a conditional expression we determine what resources we need to deploy.

### Demo 2

1. Review the code in `\pip-conditional-expression-demo\variables.tf`
1. See that variable **public_ip** is currently set to **false**
1. Review the code in `\pip-conditional-expression-demo\main.tf`
1. Check the configuration of resource **azurerm_public_ip**
1. See that we use the count function, this uses a conditional expression to check the value of **var.public** IP

     count                        = var.public_ip == "true" ? 1 : 0

1. If **true** count = **1**, if **false** count = **0**
1. This has the effect of either creating or not creating a public IP
1. Now check under resource **azurerm_network_interface**
1. We again use a conditional expression to check if a PIP will be deployed

    public_ip_address_id          = var.public_ip == "true" ? azurerm_public_ip.azurevm.0.id : ""

   1. If **var.public_ip** is **true** we will set the public ip address value to be that of the ID of the PIP create in resource **azurerm_public_ip.azurevm**
   1. If **var.public_ip** is **false** we will set the public ip address value to be blank, so no value is set
1. In the shell, Make sure you are in folder `\pip-conditional-expression-demo\`
1. Run **terraform init**
1. Run **terraform plan**, check there are no errors
1. Run **terraform apply** and answer **yes**
1. Check the Azure Portal to review what has been deployed in the resource group **terraform-demos-prd-rg**
   1. No Public IP address should have been deployed
   1. NIC settings should not have a public IP associated with it
1. Edit **variables.tf** and change change **public_ip** from **false** to **true**
1. Save the changes
1. Run **terraform plan**, check there are no errors
1. Run **terraform apply** and answer **yes**
1. Check the Azure Portal to review what has been deployed in the resource group **terraform-demos-prd-rg**
   1. A Public IP address should have been deployed
   1. NIC settings should have a public IP associated with it
1. **terraform destroy** to cleanup the resources
1. Check the resources have been deleted in the Azure Portal

## Foreach Function

The foreach function can be used to iterate through a list or map. This is an alternative to the count function. In the count function we can **append** a number to the name of resources so you can build web1, web2, web3, etc. What if we want the names to be different? Also, what if we were dealing with a different resource? For example, we have a list of users we want to assign RBAC permissions to. We could create a list of users in a variable and iterate through this with foreach to deploy role assignments for each user.

In this demo we deploy multiple web application resources like we did in the count demo, this time we use a list of app names and deploy multiple Web Apps using foreach to iterate through the list of names.

1. Review the code in `\app-service-foreach-demo\variables.tf`
1. See that variable **webapps** has three names configured, two of them are currently commented out
1. Review the code in `\app-service-foreach-demo\main.tf`
1. Check the resource **azurerm_app_service**
1. See we now have **for_each** instead of **count** and this references **var.webapps**

     for_each            = var.webapps

1. For the name of the resource we are using **each.value** which gets the name value from **var.webapps**

     name                = each.value

1. In the shell, make sure you are in folder `\app-service-foreach-demo\`
1. Run **terraform init**
1. Run **terraform plan**, check there are no errors
1. Run **terraform apply** and answer **yes**
1. Check the Azure Portal to review what has been deployed in the resource group **prd-rg**
   1. One Web App Service Plan
   1. One Web Application called **dog-fe-web-1**
1. Edit **variables.tf** and uncomment **web2** and **web3** from **var.webapps**
1. Save the changes
1. Run **terraform plan**, check there are no errors
1. Run **terraform apply** and answer **yes**
1. Run **terraform apply**
1. Check the Azure Portal to review what has been deployed in the resource group **prd-rg**
   1. One Web App Service Plan
   1. Three Web Applications **dog-fe-web-1**, **dog-be-web-2**, **demo-web-3**
1. See how we can now deploy the same resources but with very different names easily
1. **terraform destroy** to cleanup the resources
1. Check the resources have been deleted in the Azure Portal
