# tf-aws-availability-zones

This is a Terraform module to manage a list of Availability Zones in the current account which
can be used to explicitly control access to a desired list of Availability Zones in a consistent
and predictable manner.

By default, this module returns all currently known Availability Zones in the current region,
unless an Availability Zone is explicitly excluded from the results using the `exclude` variable.

## Requirements

- Terraform 0.10.x or higher.

## Dependencies

None.

## Usage

#### Example of fetching Availability Zones in the "us-east-1" region with "us-east-1b" excluded using a single letter only:

```ruby
module "availability_zones" {
  source = "./availability-zones"

  region = "us-east-1"
  exclude = ["b"]
}
```

#### Example of fetching Availability Zones in the "us-east-1" region with "us-east-1b" excluded using full name of the zone:

```ruby
module "availability_zones" {
  source = "./availability-zones"

  region = "us-east-1"
  exclude = ["us-east-1b"]
}
```

#### Example of fetching Availability Zones in current region with all the zones shuffled around randomly:

```ruby
module "availability_zones" {
  source = "./availability-zones"

  shuffle = true
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|:-----:|:-----:|:-----:|
| region | The name of the region for which to return the list of Availability Zones. | String | | No |
| exclude | A list of Availability Zones to exclude from the results. Can be either a single letter or a full name of the zone (e.g. "b" or "us-east-1b"). | List | | No |
| shuffle | | Boolean | false | No |

## Outputs

| Name | Description | Type |
|------|-------------|:----:|
| region | The current region for which to return relevant Availability Zones. | String |
| count | The number of all Availability Zones in the current region. | Integer |
| all | The list of all Availability Zones in the current region. | List |
| available | The list of Availability Zones in the current region without zones excluded using the `exclude` attribute. | List |
| available_count | The number of Availability Zones in the current region without zones excluded using the `exclude` attribute. | Integer |

## Notes

This module provides a static list of Regions and Availability Zones, and does not rely on the
Terraform [aws_availability_zones](https://www.terraform.io/docs/providers/aws/d/availability_zones.html)
data source. Since Terraform data sources are dynamic and always refresh to present up-to-date values,
such behaviour can result in an undesirable change that might be introduced to the existing infrastructure
due to either a new Availability Zone becoming available or retired in the current region.

Additionally, this module outputs contain a static values such as e.g. number of Availability Zones, etc.,
which would alleviate an issue with dynamic resources interpolation and the `count` attribute.

## Known issues

None.

## References

A Pull Request against Terraform which contains implementation details regarding issues with reliable
detection of Availability Zones:

- [Add state filter to aws_availability_zones data source.](https://github.com/hashicorp/terraform/pull/7965)

An issue which contains a discussion about a side effect of changes in the Terraform plan following
an addition of a new Availability Zone:

- [AWS Added an additional AZ to us-east-1 and now `terraform plan` causes a state change](https://github.com/hashicorp/terraform/issues/11928)

## Development

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) file for instructions regarding
the contribution to this repository.
