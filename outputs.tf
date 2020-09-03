# Region
output "region" {
  value = "${var.region}"
}

# VPC
output "vpc_id_primary" {
  description = "The ID of the VPC"
  value       = "${module.vpc_primary.vpc_id}"
}


output "baseline_version" {
  description = "Version of the baseline module"
  value       = "${module.account-baseline.baseline_version}"
}

# CIDR blocks
output "vpc_cidr_block_primary" {
  description = "The CIDR block of the VPC"
  value       = "${module.vpc_primary.vpc_cidr_block}"
}


# Subnets
output "private_subnets_cidr_blocks_primary" {
  description = "List of private subnet CIDRs"
  value       = ["${module.vpc_primary.private_subnets_cidr_blocks}"]
}

output "private_subnets_primary" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc_primary.private_subnets}"]
}

output "public_subnets_primary" {
  description = "List of IDs of public subnets"
  value       = ["${module.vpc_primary.public_subnets}"]
}

output "public_subnets_cidr_blocks_primary" {
  description = "List of private subnet CIDRs"
  value       = ["${module.vpc_primary.public_subnets_cidr_blocks}"]
}


# NAT gateways
output "nat_public_ips_primary" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = ["${module.vpc_primary.nat_public_ips}"]
}
