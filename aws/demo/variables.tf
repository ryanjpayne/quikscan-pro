variable "region" {
    description = "AWS Region to deploy resources."
    type = string
    default = "us-east-1"
}
variable "unique_id" {
    description = "A unique identifier that is prepended to all created resource names"
    type = string
    default = "quikscan-pro-demo"
}
variable "bucket_name" {
    description = "The name of the bucket that is created"
    type = string
    default = "quikscan-pro-demo-bucket"
}
variable "lambda_execution_role_name" {
    description = "The name of the lambda execution IAM role"
    type = string
    default = "quikscan-pro-demo-bucket-role"
}
variable "lambda_function_filename" {
    description = "The name of the archive to use for the lambda function"
    type = string
    default = "lambda-function.zip"
}
variable "lambda_function_name" {
    description = "The name used for the lambda function"
    type = string
    default = "quikscan-pro-demo-function"
}
variable "lambda_mitigate_threats" {
    description = "Remove malicious files from the bucket as they are discovered."
    type = string
    default = "TRUE"
}
variable "ssm_param_client_id" {
    description = "Name of the SSM parameter storing the API client ID"
    type = string
    default = "S3_FALCONX_SCAN_CLIENT_ID"
}
variable "ssm_param_client_secret" {
    description = "Name of the SSM parameter storing the API client secret"
    type = string
    default = "S3_FALCONX_SCAN_CLIENT_SECRET"
}
variable "environment_tag" {
    description = "Environment tag"
    type        = string
    default     = "QuikScan Pro Demo"
}
variable "falcon_client_id" {
    description = "The CrowdStrike Falcon API client ID"
    type = string
    default = ""
    sensitive = true
}
variable "falcon_client_secret" {
    description = "The CrowdStrike Falcon API client secret"
    type = string
    default = ""
    sensitive = true
}
variable "lambda_description" {
    description = "The description used for the lambda function"
    type = string
    default = "QuikScan Pro Demo Function"
}
variable "iam_prefix" { 
    description = "The prefix used for resources created within IAM"
	type = string
	default = "quickscan-pro-demo"
}
variable "base_url" {
    description = "The Base URL for the CrowdStrike Cloud API"
    type = string
    default = "https://api.crowdstrike.com"
}