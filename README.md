# buzzcloud-isogram
Assignment
#### Project Details

What is isogram -

Given a word or phrase, check if it is isogram or not. An Isogram is a word in which no letter occurs more than once.

##Solution :

* Write Function using python code , to check whether a given string is ISOGRAM exception of "-" and " " space is allowed multiple times.

* Write terraform code to create lambda and trigger using ApiGateway

* Cloud platform : AWS

#### High level Architecture

![image](https://user-images.githubusercontent.com/26302748/178082099-f3bca686-deb2-4fba-bb58-836c04d7e587.png)


#### Installation and modules

Install tools

* Aws CLI
* Terraform
* python3.9

Modules

- Lambda 
- APi gateway

#### Configuration

Set ACCESS_KEY and SECRET_KEY 

aws configure 

AWS Access Key ID [****************OXXH]:
AWS Secret Access Key [****************bHbu]:
Default region name [us-east-1]:
Default output format [json]:

| Secrets                                         |
|-------------------------------------------------|
|  <a name="secret1"></a> AWS_ACCESS_KEY_ID       |
|  <a name="secret2"></a> AWS_SECRET_ACCESS_KEY   |

Set region and accountId variable as default.

#variable "myregion" {
  default ="us-east-1"
}

#variable "accountId" {
  default ="xxxxxxxxx"
}

### Deployment 

$ git clone <github repo url>

$ cd <repo dir>

$ zip lambda_function.py 

$ terraform init

$ terraform plan

$ terraform apply

### Outputs Invoke Url
The Rest Api url can be used to invoke the lambda function along with query string named "string1"
 
Outputs:

|deployment_invoke_url = "https://gomhen3z03.execute-api.us-east-1.amazonaws.com/stage1"|

eg. https://gomhen3z03.execute-api.us-east-1.amazonaws.com/stage1/isogram?string1=hello

![image](https://user-images.githubusercontent.com/26302748/178081926-59e0c1cc-66f4-4378-bc57-8ec7fb9f6dcb.png)



