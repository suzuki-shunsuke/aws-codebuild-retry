resource "aws_lambda_function" "main" {
  # https://www.terraform.io/docs/language/meta-arguments/lifecycle.html#ignore_changes
  # Terraform can create and destroy the remote object but will never propose updates to it.
  lifecycle {
    ignore_changes = all
  }

  function_name = var.function_name
  role          = aws_iam_role.main.arn

  handler  = "bootstrap"                         # It would be overridden
  runtime  = "provided.al2"                      # It would be overridden
  filename = data.archive_file.dummy.output_path # It would be overridden
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/dummy.zip"

  source {
    content  = "dummy"
    filename = "bootstrap"
  }

  depends_on = [
    # This is required to create the zip file in `terraform apply`.
    # https://github.com/hashicorp/terraform-provider-archive/issues/39
    # Without this dependency, a zip file is created in `terraform plan` but isn't created in `terraform apply tfplan.binary`.
    # This is a hack, so if there is better way we want to replace this hack.
    null_resource.main
  ]
}

resource "null_resource" "main" {}
