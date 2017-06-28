provider "aws" {}

module "key_pair_test_1" {
  source = "../../"

  stack_name = "test_1"
}

module "key_pair_test_2" {
  source = "../../"

  stack_name = "test_2"
  public_key = "../fixtures/id_rsa.pub"
  key_name   = "key_pair_test_2"
}

output "key_pair_test_1_key_name" {
  value = "${module.key_pair_test_1.key_name}"
}

output "key_pair_test_1_algorithm" {
  value = "${module.key_pair_test_1.algorithm}"
}

output "key_pair_test_1_fingerprint" {
  value = "${module.key_pair_test_1.fingerprint}"
}

output "key_pair_test_2_key_name" {
  value = "${module.key_pair_test_2.key_name}"
}

output "key_pair_test_2_fingerprint" {
  value = "${module.key_pair_test_2.fingerprint}"
}
