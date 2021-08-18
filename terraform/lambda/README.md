# lambda

Terraform Module of Lambda Function

## Resources

* Lambda Function
  * update of all attributes is ignored by life cycle policy. Terraform can create and destroy the remote object but will never propose updates to it.
* IAM Role and policy to invoke Lambda Function
* Cloudwatch Log group to store Lambda Function's log

## Examples

```tf
module "lambda" {
  source                = "./lambda"
  function_name         = "hello"
  log_retention_in_days = 30
}
```

## Variables

Please see [variables.tf](variables.tf).

## Outputs

Please see [outputs.tf](outputs.tf).
