#variables declaration

variable "myregion" {
  default ="us-east-1"
}
variable "accountId" {
  default ="341672303817"
}

# API Gateway definition 
resource "aws_api_gateway_rest_api" "api"  {
  api_key_source               = "HEADER"
    
    binary_media_types           = []
    
    description                  = "Trigger Lambda"
    disable_execute_api_endpoint = false
    
    
    minimum_compression_size     = -1
    name                         = "isogram-API"
    
    tags                         = {}
    tags_all                     = {}

    endpoint_configuration {
        types            = [
            "REGIONAL",
        ]
        
    }
}


# Api Root resource configuration
resource "aws_api_gateway_resource" "resource" {
  path_part   = "isogram"
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}
# Api Gateway Method configuration
resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Api Gateway Integration configuration for lambda invokation
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.test_lambda.invoke_arn
  
}

# Lambda Permision for invoking the function
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}


# Lambda function declaration

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {

architectures                  = [
        "x86_64",
    ]
    function_name                  = "isogram"
    filename      = "lambda_function.py.zip"
    layers                         = []
    memory_size                    = 128
    package_type                   = "Zip"
    handler = "lambda_function.lambda_handler"
    reserved_concurrent_executions = -1
    role                           = aws_iam_role.iam_for_lambda.arn
    runtime                        = "python3.9"
    source_code_hash               =  filebase64sha256("lambda_function.py.zip")
    
    tags                           = {}
    tags_all                       = {}
    timeout                        = 3
    
    ephemeral_storage {
        size = 512
    }

    timeouts {}

    tracing_config {
        mode = "PassThrough"
    }

}

# Api Deployment configuration
resource "aws_api_gateway_deployment" "MyAPiDeployment" {
  depends_on = [aws_api_gateway_integration.integration]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "stage1"

  variables = {
    "answer" = "42"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Definng output variable for invoke url
output "deployment_invoke_url" {
  description = "Deployment invoke url"
  value       = aws_api_gateway_deployment.MyAPiDeployment.invoke_url
}
