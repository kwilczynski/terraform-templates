Terraform templates, examples, etc.

```bash
$ terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "null" (1.0.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.7"
* provider.null: version = "~> 1.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```bash
$ terraform apply -var count=12
var.cidr_block
  Enter a value: 172.32.0.0/16

var.to
  Enter a value: 20

data.null_data_source.parser: Refreshing state...
data.null_data_source.integers: Refreshing state...
data.aws_availability_zones.available: Refreshing state...
data.null_data_source.networks[0]: Refreshing state...
...
data.null_data_source.even[0]: Refreshing state...
...
data.null_data_source.odd[0]: Refreshing state...
...

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

address = 172.32.0.0
all = [
    172.32.0.0/20,
    172.32.16.0/20,
    172.32.32.0/20,
    172.32.48.0/20,
    172.32.64.0/20,
    172.32.80.0/20,
    172.32.96.0/20,
    172.32.112.0/20,
    172.32.128.0/20,
    172.32.144.0/20,
    172.32.160.0/20,
    172.32.176.0/20
]
cidr_block = 172.32.0.0/16
count = 12
even = [
    172.32.0.0/20,
    172.32.32.0/20,
    172.32.64.0/20,
    172.32.96.0/20,
    172.32.128.0/20,
    172.32.160.0/20
]
halve_1 = [
    172.32.0.0/20,
    172.32.16.0/20,
    172.32.32.0/20,
    172.32.48.0/20,
    172.32.64.0/20,
    172.32.80.0/20
]
halve_2 = [
    172.32.96.0/20,
    172.32.112.0/20,
    172.32.128.0/20,
    172.32.144.0/20,
    172.32.160.0/20,
    172.32.176.0/20
]
hosts = 4094
netmask = 255.255.0.0
odd = [
    172.32.16.0/20,
    172.32.48.0/20,
    172.32.80.0/20,
    172.32.112.0/20,
    172.32.144.0/20,
    172.32.176.0/20
]
ptr = 32.172.in-addr.arpa
regions = [
    us-east-1a,
    us-east-1b,
    us-east-1c,
    us-east-1d,
    us-east-1e,
    us-east-1f
]
subnets = 16
```

```bash
$ terraform apply
var.cidr_block
  Enter a value: 172.32.0.0/16

var.to
  Enter a value: 20

data.null_data_source.parser: Refreshing state...
data.null_data_source.integers: Refreshing state...
data.aws_availability_zones.available: Refreshing state...
data.null_data_source.networks[0]: Refreshing state...
...
data.null_data_source.even[0]: Refreshing state...
...
data.null_data_source.odd[0]: Refreshing state...
...

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

address = 172.32.0.0
all = [
    172.32.0.0/20,
    172.32.16.0/20,
    172.32.32.0/20,
    172.32.48.0/20,
    172.32.64.0/20,
    172.32.80.0/20
]
cidr_block = 172.32.0.0/16
count = 0
even = [
    172.32.0.0/20,
    172.32.32.0/20,
    172.32.64.0/20,
    172.32.0.0/20,
    172.32.32.0/20,
    172.32.64.0/20,
    172.32.0.0/20,
    172.32.32.0/20
]
halve_1 = [
    172.32.0.0/20,
    172.32.16.0/20,
    172.32.32.0/20
]
halve_2 = [
    172.32.48.0/20,
    172.32.64.0/20,
    172.32.80.0/20
]
hosts = 4094
netmask = 255.255.0.0
odd = [
    172.32.16.0/20,
    172.32.48.0/20,
    172.32.80.0/20,
    172.32.16.0/20,
    172.32.48.0/20,
    172.32.80.0/20,
    172.32.16.0/20,
    172.32.48.0/20
]
ptr = 32.172.in-addr.arpa
regions = [
    us-east-1a,
    us-east-1b,
    us-east-1c,
    us-east-1d,
    us-east-1e,
    us-east-1f
]
subnets = 16
```
