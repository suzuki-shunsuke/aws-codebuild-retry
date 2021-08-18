module "lambda" {
  source                = "./lambda"
  function_name         = "codebuild-retry"
  log_retention_in_days = 30
}

resource "aws_iam_role_policy" "retry-build" {
  name   = "retry-build"
  policy = data.aws_iam_policy_document.retry-build.json
  role   = module.lambda.role_name
}

data "aws_iam_policy_document" "retry-build" {
  statement {
    actions = [
      "codebuild:RetryBuild",
    ]

    resources = ["*"]
  }
}

resource "aws_cloudwatch_event_rule" "main" {
  name        = "codebuild-provisioning-error"
  description = "CodeBuild Provisioing Error"

  # is_enabled = false # TODO enable after the lambda function is set up

  event_pattern = jsonencode({
    "source" : ["aws.codebuild"],
    "detail-type" : [
      "CodeBuild Build Phase Change",
    ],
    "detail" : {
      "completed-phase-status" : ["FAILED"],
      "completed-phase" : ["PROVISIONING"],
      # TODO remove this condition to retry all projects
      # For testing, we restrict the project.
      # "project-name" : [
      #   "foo",
      # ],
    },
  })
}

resource "aws_cloudwatch_event_target" "main" {
  rule = aws_cloudwatch_event_rule.main.name
  arn  = module.lambda.function_arn
}

resource "aws_lambda_permission" "main" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.main.arn
}
