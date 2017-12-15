# tf-aws-vpc-endpoint

This is a Terraform module to create a VPC Endpoint between a VPC and an AWS service,
for all the instances running inside associated subnets.

By default, this module creates a VPC Endpoint for the S3 service, and a two sub-modules
are available for convenience that can be included in order to create a VPC Endpoint for
either the S3 or/and DynamoDB services.

## Requirements

- Terraform 0.10.x or higher.

## Dependencies

None.

## Usage

#### Example of a VPC Endpoint for S3 added to two route tables, and using default policy:

```ruby
module "vpc_endpoint_s3" {
  source = "../vpc-endpoint"

  vpc_id = "${aws_vpc.vpc.id}"

  route_table_ids = [
    "${aws_route_table.public.id}",
    "${aws_route_table.private.id}"
  ]
}
```

#### Example of a VPC Endpoint for DynamoDB added to a single route table, and using default policy:

```ruby
module "vpc_endpoint_dynamodb" {
  source = "../vpc-endpoint/dynamodb"

  vpc_id = "${aws_vpc.vpc.id}"

  route_table_ids = ["${aws_route_table.private.id}"]
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|:-----:|:-----:|:-----:|
| vpc_id | The ID of the VPC in which the endpoint will be created. | String | | Yes |
| route_table_ids | A list of route table IDs to associate the endpoint with. | List | | Yes |
| service | The AWS service name for which to create the endpoint, can be either "s3" or "dynamodb". | String | s3 | No |
| policy | A policy to attach to the VPC Endpoint that controls access to the underlying AWS service. | String | | No |
| depends_on | A list of dependencies to hook into the underlying `aws_vpc_endpoint` resource in this module. This value should be a list that contains interpolations from the resources you want to add as dependencies. | List || No |

## Outputs

| Name | Description | Type |
|------|-------------|:----:|
| id | The ID of the VPC Endpoint. | String |
| vpc_id | The ID of the VPC where the endpoint was created. | String |
| prefix_list_id | The prefix list ID of AWS service exposed through the endpoint. | String |
| cidr_blocks | The list of CIDR blocks for AWS service exposed through the endpoint. | List |
| route_table_ids | The list of route table IDs associated with the endpoint. | List |

## Notes

None.

## Known issues

None.

## References

This module uses Terraform [aws_vpc_endpoint](https://www.terraform.io/docs/providers/aws/r/vpc_endpoint.html)
resource, and also [aws_vpc_endpoint_service](https://www.terraform.io/docs/providers/aws/d/vpc_endpoint_service.html)
and [aws_iam_policy_document](https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html) data sources.

## Development

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) file for instructions regarding
the contribution to this repository.
