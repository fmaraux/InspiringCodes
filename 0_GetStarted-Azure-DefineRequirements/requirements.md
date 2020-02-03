# Exercice 1 : Requirement Definitions
## Project description
Our company wants to migrate an application to a public cloud. By doing this, they would like to offer SLA to our customer, especially regarding:
. **High availability** of the application
. **confidentiality** of exposed data

We have to explain us what would be the benefits and the limitations of using a public cloud infrastructure

### Object of the application
Our company uses this application as Managed service provider for different customers.
The application is a webapp used to manage specific agents installed on customers sites. 
Customer can log on the admin UI of the application to manage the solution. The admin page of the application is reachable from the Internet 

### Architecture of the application
The on-prem application is deployed as followed:
1. 1 cluster of **NGFW** protects access to the console. **AV**, **IPS** are enabled on this box. HTTP and HTTPS flow are analyzed
2. a **load balancer** is installed in front of the application. **WAF** is enabled on this blox 
3. The application runs on a Linux server with **NGINX** and **MongoDB**

# Answers to the different requirements

## What services should the public cloud deployment offer to the customers?
We have to deploy the same service than the ones used on-prem.
_Note: I'll name Azure services but I would have to do the same exercices with AWS and GCP_

- **FW** : We can migrate the on-prem virtual appliance and configure **NSG** to limit external access to the application. But I would prefer keep a true NGFW. Moreover we used IPS and AV prevention and we would keep those protection level.
--> So we'll install a virtual FW in our public tenant. 
_How can we redirect traffic from the VM that hosts our application to our virtual FW? In other words, how can we configure our virtual FW as Default Gateway in our Vnet?_ 

- **LB and WAF**: regarding LB, I'm wondering if we should use our own LB _(in other words, using a virtual instance of it installed in the cloud, as we did with the FW)_, or use the **native load balancers** and **WAF** services of the public cloud. It may be more difficult to migrate our WAF rules to the native WAF of the public cloud. reagrding, LB, using the native service may be enough.

- **The application** Obviously, we'll purchase a workload on the public cloud and pay for all the associated resources _(VNET, Subnet, VMNIC, VM, NSG, Public IP address, Storage)_ . 

_Note:_
As public cloud deployment uses several "objects" mapped together, I'm wondering if we can improve the High availability of our application by using a share storage between 2 VMs installed in different **Availability zones**? 
For example:
1. 1 VM with app/MongoDB installed in Availability zone 1 // Another one in availability zone 2
2. Both VMs using the same storage extended in both availability zones 1 and 2
3. a LB in front of the VM (in Active/Passive mode)
4. in case of failure of VM1, LB redirects to VM2 that has the same data because it uses the same storage than VM1 


## How will the users consume those services? Will they use Internet access or will you have to provide a more dedicated connectivity solution?
They'll use Internet access only. But we want to protect this access via a virtual NGFW hosted in our tenant
we'll have to check how we can redirect flows from our VM to the virtual NGFW

## Identify the data needed by the solution you're deploying. What data is shared with other applications? Where will the data reside?
This application is a standalone web-app that uses a MongoDB hosted on the same server.
As explained in my previous note, I'm wondering if the storage could be shared between 2 VMs in different availability zones to improve our HA

## What are the security requirements of your application?
This application is accessed by external users from Internet.
It has to be protected by NGFW, AV, IPS and WAF.
Question: Which of the following native service could be used ? 
From my POV, we should use our ownd NGWF instead of NGS. Following this, we'll continue to use external AV and IPS services.
Reagrding WAF, I have no idea of the value of the native one.

## What are the high availability requirements?
We want to increase the SLA of the on-prem application.
Today, the application is hosted on ESXi and we're using failover vmware services like vmotion to expect a console always available for customers. On the other hands, agents are autonomous. They continue to work even if they loose connections.
*Note: Can we say that a VM installed in a public cloud has the same level of HA than an on-prem VM running on ESXi cluster (with VMotion enabled etc. ?)*

## Do you have to provide connectivity to your on-premises data center? If so, how will you implement it?
Yes we may have to provide a connectivity to our DC. For example: for **monitoring** purpose. It may be interesting to have the same solution that monitors our on-prem workloads and our workloads hosted on public cloud
In that case, we'll configure an IPSec VPN between our DC and a **VPN Gateway** in Azure tenant for example

*Note: What is the difference between VPN Gateway and On-premises Data Gateway?*


## Do you have to implement connectivity to other (customer) sites? If so, how will you implement it?
No we won't have such scenario.
If we had it, I guess we should connect other customers sites with VPN Gateway too?

