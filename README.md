# aws-codebuild-retry

[![Build Status](https://github.com/suzuki-shunsuke/aws-codebuild-retry/workflows/test/badge.svg)](https://github.com/suzuki-shunsuke/aws-codebuild-retry/actions)
[![Go Report Card](https://goreportcard.com/badge/github.com/suzuki-shunsuke/aws-codebuild-retry)](https://goreportcard.com/report/github.com/suzuki-shunsuke/aws-codebuild-retry)
[![GitHub last commit](https://img.shields.io/github/last-commit/suzuki-shunsuke/aws-codebuild-retry.svg)](https://github.com/suzuki-shunsuke/aws-codebuild-retry)
[![License](http://img.shields.io/badge/license-mit-blue.svg?style=flat-square)](https://raw.githubusercontent.com/suzuki-shunsuke/aws-codebuild-retry/master/LICENSE)

AWS Lambda Function to retry CodeBuild's build which failed due to the provisioning error.

Sometimes CodeBuild's build fails due to the provisioning error.

You can handle the error by AWS CloudWatch Event and retry the build by Lambda Function.

## LICENSE

[MIT](LICENSE)
