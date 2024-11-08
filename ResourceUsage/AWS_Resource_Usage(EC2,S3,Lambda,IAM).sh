#!/bin/bash
#############
# AUTHOR:Naveen
# DATE:06/11/2024
# VERSION:V1
#
#This Script will help you to track the aws_resources_usage
###############

set - x # Help you to execute on Debug Mode
set - e # Help to exits if the script failed
set - o # Helps to exits the script filed on pipe lines

# AWS S3
# AWS EC2
# AWS LAMBDA
# AWS IAM USERS

# List S3 Buckets
echo "Print list s3 buckets"
aws s3 ls > ResourceTracker
# "> ResourceTracker - This helps you to put the data on the ResourceTracker file"

# List AWS_EC2 Instances
echo "Print list EC2 Instances"
aws ec2 describe-instances | jq 'Reservations[].Instances[].InstanceID[]' > ResourceTracker

#(|- Pipe will help you send the previour output, jq-refers as Json Path & yq refers as YAML Path & ('Reservations[].Instances[].InstanceID[]')- helps you to provide the data which are available in Instance ID, this provide the path)

# List Lambda
echo "Print list Lambda"
aws lambda list-functions > ResourceTracker

# List IAM Users
echo "Print list IAM Users"
aws iam list-users > ResourceTracker
