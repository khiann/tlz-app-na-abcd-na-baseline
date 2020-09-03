# AWS Provider Variables
variable "region" {
  description = "AWS Region to deploy to"
  default     = "us-east-2"
}

variable "region_secondary" {
  description = "AWS secondary region to deploy to"
}

variable "role_name" {
  description = "AWS role name to assume"
  default     = "TLZOrgAdmin"
}

# Account Variables
variable "account_id" {
  description = "The ID of the working account"
}

variable "account_type" {
  description = "The Account Type of working account"
}

variable "environment" {
  description = "The environment of Account"
}

variable "int_environment" {
  description = "The int_environment of Account"
}

variable "name" {
  description = "Name of the account"
}

variable "okta_provider_domain" {
  description = "The domain name of the IDP.  This is concatenated with the app name and should be in the format 'site.domain.tld' (no protocol or trailing /)."
}

variable "okta_app_id" {
  description = "The Okta app ID for SSO configuration."
}

# VPC Variables
variable "cidr_primary" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "0.0.0.0/0"
}

variable "azs_primary" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "cidr_secondary" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "0.0.0.0/0"
}

variable "azs_secondary" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default = {
    "TGW" = "app-test"
  }
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block"
  default     = false
}

variable "enable_s3_endpoint" {
  description = "Configure an S3 Endpoint on the VPC"
  default     = false
}

variable "enable_dynamodb_endpoint" {
  description = "Configure a DynamoDB Endpoint on the VPC"
  default     = false
}


variable "tfe_host_name" {
  description = "host_name for ptfe"
}

variable "tfe_org_name" {
  description = "ptfe organization name"
}
variable "tfe_avm_workspace_name" {
  description = "Name of avm workspace"
}
variable "tfe_core_logging_workspace_name" {
  description = "Name of logging workspace"
}

variable "core_network_account" {
  description = "Core Networking Account ID"
}
