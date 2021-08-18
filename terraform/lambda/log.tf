# Create a IAM Policy instead of AWSLambdaBasicExecutionRole
# https://console.aws.amazon.com/iam/home?region=ap-northeast-1#/policies/arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole$jsonEditor
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/iam-access-control-overview-cwl.html
resource "aws_iam_role_policy" "log" {
  name   = "log"
  policy = data.aws_iam_policy_document.log.json
  role   = aws_iam_role.main.name
}

data "aws_iam_policy_document" "log" {
  statement {
    actions   = ["logs:CreateLogStream"]
    resources = ["${aws_cloudwatch_log_group.main.arn}:log-stream:*"]
  }
  statement {
    actions   = ["logs:PutLogEvents"]
    resources = ["*"]
  }
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days
}
