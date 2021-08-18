package handler

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/request"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/codebuild"
)

func Start(ctx context.Context) error {
	sess := session.Must(session.NewSession())
	handler := &Handler{
		CodeBuild: codebuild.New(sess),
	}

	lambda.StartWithContext(ctx, handler.Start)
	return nil
}

type Handler struct {
	CodeBuild CodeBuild
}

type CodeBuild interface {
	// RetryBuildBatchWithContext(ctx aws.Context, input *codebuild.RetryBuildBatchInput, opts ...request.Option) (*codebuild.RetryBuildBatchOutput, error)
	RetryBuildWithContext(ctx aws.Context, input *codebuild.RetryBuildInput, opts ...request.Option) (*codebuild.RetryBuildOutput, error)
}

// Start is the Lambda Function's endpoint.
func (handler *Handler) Start(ctx context.Context, event *events.CodeBuildEvent) error {
	// debug
	if err := json.NewEncoder(os.Stderr).Encode(event); err != nil {
		return fmt.Errorf("output payload for debug: %w", err)
	}
	// TODO consider batch build
	_, err := handler.CodeBuild.RetryBuildWithContext(ctx, &codebuild.RetryBuildInput{
		Id: aws.String(event.Detail.BuildID),
	})
	if err != nil {
		return fmt.Errorf("retry build %s: %w", event.Detail.BuildID, err)
	}
	return nil
}
