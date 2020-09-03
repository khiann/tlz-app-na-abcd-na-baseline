![Terraform GitHub Actions](https://github.com/tlzproject/at-application-account/workflows/Terraform%20GitHub%20Actions/badge.svg)

# Application account
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_id | The ID of the working account | string | - | yes |
| assign\_generated\_ipv6\_cidr\_block | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block | string | `false` | no |
| azs\_primary | A list of availability zones in the region | list | `<list>` | no |
| cidr\_primary | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | string | `0.0.0.0/0` | no |
| enable\_nat\_gateway | Should be true if you want to provision NAT Gateways for each of your private networks | string | `false` | no |
| name | Name of the account | string | - | yes |
| region | AWS Region to deploy to | string | `us-east-2` | no |
| role\_name | AWS role name to assume | string | `OrganizationAccountAccessRole` | no |
| single\_nat\_gateway | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | string | `false` | no |
| tags | A map of tags to add to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| baseline\_version | Version of the baseline module |
| nat\_public\_ips\_primary | List of public Elastic IPs created for AWS NAT Gateway |
| private\_subnets\_cidr\_blocks\_primary | List of private subnet CIDRs |
| private\_subnets\_primary | List of IDs of private subnets |
| public\_subnets\_cidr\_blocks\_primary | List of private subnet CIDRs |
| public\_subnets\_primary | List of IDs of public subnets |
| vpc\_cidr\_block\_primary | The CIDR block of the VPC |
| vpc\_id\_primary | The ID of the VPC |
