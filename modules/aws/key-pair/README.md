# key-pair

This is a Terraform module to create a key-pair in the current account which can be used when  
starting a standalone EC2 instances or as part of the Auto-Scaling Group launch configuration.

By default, this module creates both the public and private keys automatically, and derives  
name of the key-pair to be created from the `stack_name` variable. An existing public key in  
the OpenSSH public key format can be provided using the `public_key` variable, whereas the  
key-pair name can be overridden using the `key_name` variable.

## Requirements

- Terraform 0.10.x or higher;
- Bash 4.0 or higher;
- jq 1.5 or higher.

This module requires a Bash shell and jq for its helper script, and assumes that the jq binary  
is available from within the current environment.

## Dependencies

None.

## Usage

#### Example of a key-pair with public and private keys created automatically:

```ruby
module "example_key_pair" {
  source = "./key-pair"

  stack_name = "example-stack"
}
```

#### Example of a key-pair using public key given as an inline value and a custom key-pair name:

```ruby
module "deploy_key_pair" {
  source = "./key-pair"

  stack_name = "example-stack"
  public_key = "ssh-rsa AAAAB3NzaC1 (...)"
  key_name   = "deploy"
}
```

#### Example of a key-pair with an existing public key and a custom key-pair name:

```ruby
module "jenkins_key_pair" {
  source = "./key-pair"

  stack_name = "example-stack"
  public_key = "./example/id_rsa.pub"
  key_name   = "jenkins"
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|:-----:|:-----:|:-----:|
| stack_name | A custom stack name to use. | String || Yes |
| algorithm | The name of the algorithm to use for the key, can be either "RSA" or "ECDSA". Note that the elliptic curve algorithm "ECDSA" is currently not supported by AWS.| String | RSA | No ||
| rsa_bits | The size of the generated RSA key in bits. | Integer | 4096 | No ||
| ecdsa_curve | The name of the elliptic curve to use, can be either "P224", "P256", "P384", or "P521". | String | P384 | No |
| public_key | Either path to file containing public key in the OpenSSH public key format, or a value containing the public key. | String || No |
| key_name | The name of the key-pair. | String || No |
| depends_on | A list of dependencies to hook into the underlying `aws_key_pair` resource in this module. This value should be a list that contains interpolations from the resources you want to add as dependencies. | List || No |

## Outputs

| Name | Description | Type |
|------|-------------|:----:|
| key_name | The name of the key-pair. | String |
| algorithm | The name of the algorithm that was selected for the key. | String |
| private_key_pem | The private key in the PEM format. | String |
| public_key_pem | The public key in the PEM format. | String |
| public_key | The public key in the OpenSSH public key format. | String |
| fingerprint | The public key fingerprint as 128-bit MD5 value. | String |

## Notes

This module uses am external data source and a helper script called `public-key.sh` in order to  
provide an ability for the module to handle the following two use cases:

1. Create a new key-pair automatically, when no public key has been provided; or  
2. Use existing public key if a valid path to a file has been given.

Unfortunately, this could not be implemented using the `file` helper from Terraform, as such  
helpers always execute (even if the resource block has `count` attribute set to 0), therefore  
passing an empty variable would result in a failure due to an inability for the `file` helper  
to locate and load a file from a given path. The external data source, which would also execute  
every time, contains a logic to check whether a file exists or not, and either return content  
of the file or an empty value otherwise.

## Known issues

The fingerprint output value might not be immediately available after the key-pair has been  
created, which can be resolved by either running `terraform refresh` or `terraform apply`  
again in order to force Terraform to refresh dynamically computed values.

In a case where the public and private keys were created automatically, then the private  
key will be stored unencrypted in the resulting Terraform state file. This should be taken  
into consideration as a possible security risk, therefore use of such key-pair for production  
deployments is generally _not_ recommended.

## References

This module uses Terraform [aws_key_pair](https://www.terraform.io/docs/providers/aws/r/key_pair.html) and
[tls_private_key](https://www.terraform.io/docs/providers/tls/r/private_key.html) resources, and the
[External Data Source](https://www.terraform.io/docs/providers/external/data_source.html) internally.

For the details about private and public keys formats, see the following documents:

- "The Secure Shell (SSH) Transport Layer Protocol", [RFC4253](https://tools.ietf.org/html/rfc4253); and
- "The Secure Shell (SSH) Public Key File Format", [RFC4716](https://tools.ietf.org/html/rfc4716).

For latest jq binary, see the download section at the jq project [page](https://stedolan.github.io/jq/).
