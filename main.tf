# Connect to the core-logging account to get VPC FlowLog destinations
data "terraform_remote_state" "logging" {
  backend = "remote"

  config = {
    organization = var.tfe_org_name
    hostname     = var.tfe_host_name

    workspaces = {
      name = var.tfe_core_logging_workspace_name
    }
  }
}


# Tagging foundation for resources in account
module "example-tagging" {
  source = "cloudposse/label/null"
  //version = "~> 0.0.1"
  namespace = "tlz"
  stage     = var.environment

}


module "vpc_label" {
  source  = "cloudposse/label/null"
  context = module.example-tagging.context
  name    = "Primary VPC"
}


# Networking
module "vpc_primary" {
  source = "git@github.com:tlzproject/terraform-aws-vpc.git"

  name                     = "tlz-vpc"
  cidr                     = var.cidr_primary
  azs                      = var.azs_primary
  private_subnets          = local.private_subnets_primary
  public_subnets           = local.public_subnets_primary
  enable_nat_gateway       = var.enable_nat_gateway
  single_nat_gateway       = var.single_nat_gateway
  enable_s3_endpoint       = var.enable_s3_endpoint
  enable_dynamodb_endpoint = var.enable_dynamodb_endpoint
  tags                     = module.vpc_label.tags

  assign_generated_ipv6_cidr_block        = var.assign_generated_ipv6_cidr_block
  vpc_flowlogs_cloudwatch_destination_arn = data.terraform_remote_state.logging.outputs.vpc_flowlogs_primary_destination_arn
}

# Account baseline
module "account-baseline" {
  source                 = "git@github.com:tlzproject/terraform-aws-baseline-common.git"
  account_name           = var.name
  account_type           = var.account_type
  account_id             = var.account_id
  okta_provider_domain   = var.okta_provider_domain
  okta_app_id            = var.okta_app_id
  region                 = var.region
  region_secondary       = var.region_secondary
  role_name              = var.role_name
  config_logs_bucket     = data.terraform_remote_state.logging.outputs.s3_config_logs_bucket_name
  tfe_host_name          = var.tfe_host_name
  tfe_org_name           = var.tfe_org_name
  tfe_avm_workspace_name = var.tfe_avm_workspace_name
  okta_environment       = var.int_environment
  #tags_label_context     = module.example-tagging.context
}

module "tlz_it_operations" {
  source            = "git@github.com:tlzproject/terraform-aws-baseline-common.git//modules/iam-tlz_it_operations"
  okta_provider_arn = module.account-baseline.okta_provider_arn
  deny_policy_arns  = module.account-baseline.deny_policy_arns
  #tags_label_context = module.example-tagging.context
}

module "tlz_intra_network" {
  source            = "git@github.com:tlzproject/terraform-aws-baseline-common.git//modules/iam-tlz_intra_network"
  okta_provider_arn = module.account-baseline.okta_provider_arn
  deny_policy_arns  = module.account-baseline.deny_policy_arns
  #tags_label_context = module.example-tagging.context
}

module "tlz_admin" {
  source            = "git@github.com:tlzproject/terraform-aws-baseline-common.git//modules/iam-tlz_admin"
  okta_provider_arn = module.account-baseline.okta_provider_arn
  okta_environment  = var.int_environment
  deny_policy_arns  = module.account-baseline.deny_policy_arns
  #tags_label_context = module.example-tagging.context
}

module "tlz_developer" {
  source            = "git@github.com:tlzproject/terraform-aws-baseline-common.git//modules/iam-tlz_developer"
  okta_provider_arn = module.account-baseline.okta_provider_arn
  okta_environment  = var.int_environment
  region            = var.region
  region_secondary  = var.region_secondary
  deny_policy_arns  = module.account-baseline.deny_policy_arns
  #tags_label_context = module.example-tagging.context
}

module "tlz_developer_ro" {
  source            = "git@github.com:tlzproject/terraform-aws-baseline-common.git//modules/iam-tlz_developer_ro"
  okta_provider_arn = module.account-baseline.okta_provider_arn
  #tags_label_context = module.example-tagging.context
}

module "iam-user-terraform_svc" {
  source    = "git@github.com:tlzproject/terraform-aws-baseline-common.git//modules/iam-user-tlz_svc_user"
  user_name = "terraform_svc"
  #tags_label_context = module.example-tagging.context
}

#TODO: Cirrus-630 needs to hook in with okta to provide actual access. Both SecOps and IR roles
module "tlz_security_ir" {
  source            = "git@github.com:tlzproject/terraform-aws-baseline-common.git//modules/iam-policy-securityir"
  okta_provider_arn = module.account-baseline.okta_provider_arn
  #tags_label_context = module.example-tagging.outputs.context
}

/*
module "transit-gateway" {
  source               = "app.terraform.io/cap-tlz/transit-gateway/aws"
  version              = "~> 0.0.1"
  tfe_host_name        = var.tfe_host_name
  tfe_org_name         = var.tfe_org_name
  account_id           = var.account_id
  role_name            = var.role_name
  vpc_id               = module.vpc_primary.vpc_id
  name                 = var.name
  core_network_account = var.core_network_account
  tags_label_context   = module.example-tagging.context
}
*/