data "aws_iam_policy_document" "mod" {
  count = "${var.assume_role_policy != "" ? 0 : 1}"

  statement {
    principals {
      type        = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "mod" {
  name = "${format("%s-%s-instance-role", var.stack_name, var.name)}"

  assume_role_policy = "${coalesce(var.assume_role_policy, join("",
                          data.aws_iam_policy_document.mod.*.json))}"
}

resource "aws_iam_instance_profile" "mod" {
  name = "${format("%s-%s-instance-profile", var.stack_name, var.name)}"
  role = "${aws_iam_role.mod.name}"

  // This is to resolve an issue with Instance Profile creation,
  // where the underlying profile is still being created, but other
  // resources that use it would try to access it already, see:
  // https://github.com/hashicorp/terraform/issues/1885
  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = ["aws_iam_role.mod"]
}
