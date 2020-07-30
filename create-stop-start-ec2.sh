#!/bin/bash
## Create bucket 
echo "Create bucket..."
aws s3api create-bucket \
--bucket jaf-deploy \
--region sa-east-1 \
--create-bucket-configuration LocationConstraint=sa-east-1

## Send app to s3
echo "Upload..."
aws s3 cp stop-start-instance-1.1.zip s3://jaf-deploy/lambdas/

## Create Stack
aws cloudformation create-stack \
--region sa-east-1 \
--stack-name hlg-stop-start-ec2 \
--template-body file://cf-stop-start-ec2-instances.yml \
--parameters file://parameters.json \
--capabilities CAPABILITY_NAMED_IAM 
