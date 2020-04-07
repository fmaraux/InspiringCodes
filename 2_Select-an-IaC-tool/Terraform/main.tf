# main module to deploy network and webVM

provider "azurerm" {
version = "=2.0.0"
features {}
}

module "network" {
	source = "./modules/network"
  location = var.location
  rg_name  = var.rg_name
}

module "WebVM" {
	source = "./modules/compute"

  rg_name  = var.rg_name
  location = var.location
  nic_id = module.network.nicID
}
