output "role_name" {
  value       = aws_iam_role.main.name
  description = "Name of Lambda Function Execution Role"
}

output "invoke_arn" {
  value       = aws_lambda_function.main.invoke_arn
  description = "Invoke ARN of Lambda Function"
}

output "function_arn" {
  value       = aws_lambda_function.main.arn
  description = "ARN of Lambda Function"
}

output "function_name" {
  value       = aws_lambda_function.main.function_name
  description = "Lambda Function Name"
}
