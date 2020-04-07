# variables for network.tf

variable "location" {
	description = "Azure location"
	type = string
	default = null
}

variable "rg_name" {
	type = string
	default = null
}

variable "network_name" {
	type = string
	default = "VNet-LABFM"
}

variable "network_ip" {
	type = list(string)
	default = ["10.201.28.0/24"]
}

variable "public_sub_name" {
	type = string
	default = "FM-Public"
}

variable "public_sub_address" {
	type = string
	default = "10.201.28.16/28"
}

variable "private_sub_name" {
	type = string
	default = "FM-Private"
}

variable "private_sub_address" {
	type = string
	default = "10.201.28.32/28"
}

variable "rt_name" {
	type = string
	default = "Private_RT"
}

variable "route_name" {
	type = string
	default = "drop_Int_access"
}

variable "pub_ip_name" {
	type = string
	default = "VM_Public_IP"
}

variable "pub_ip_method" {
	type = string
	default = "Static"
}

variable "sg_name" {
	type = string
	default = "Public_SG"
}

variable "nic_name" {
	type = string
	default = "VM_NIC"
}

variable "nic_ip_conf_name" {
	type = string
	default = "VM_NIC_Config"
}