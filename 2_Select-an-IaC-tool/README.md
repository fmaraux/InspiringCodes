# Exercice 2 : Your First Infrastructure-as-Code Deployment

## What you have to do

  After creating an account with a public cloud provider and selecting IaC tool, you have to:

1. create a single public cloud resource using infrastructure-as-code tool of your choice.

  * You could do something as simple as creating a tenant network (VPC/Vnet) with RFC 1918 prefix
  * or deploy a virtual machine.

2. After you managed to create the selected public cloud resource change the definition file to rename it, change its parameters, or remove it.

## Solution

I chose to use **terraform** as IaC tool.
In order to do this hands-on-exercice, I used the code provided as an example in ipspace git: **https://github.com/ipspace/pubcloud/tree/master/Azure/Terraform**

### 1. Change done on the original code

After looking at the code: I change the different value of "main" and "network" variables, especially:
* location
* rg_name
* Network_name
* Network_ip
* public_sub_name and private_sub_name
* public_sub_address and private_sub_address

### 2. Caveats that I had to deal with

During *Terraform validate* phase, some errors appeared:
* **Feature required field is not set**
    I have to add the following line to main.tf file:
    *features {}*
* **argument not expected**
    I have to delete 2 lines on the original code:
    *route_table_id = azurerm_route_table.tf_RT.id*
    *network_security_group_id = azurerm_network_security_group.tf_sg.id*

* **Limitations with subscriptions and locations**
    I have to change my location several time due to:
    * limitation on the number of available public IP address per region
    * no possibility to add VM in a specific region in our subscription

    ### 3. Results

Infrastructure as a code was finally applied as expected. 
My last test was to change name of private network so as to see how changes are managed by terraform

Finally with **Terraform destroy**, all the components deployed previously were deleted



