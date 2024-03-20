# Terraform Guide

Terraform is good for
1. Create infrastructure by code
2. One code can be easily migrated to any other platform, like an AWS code can be migrated to GCP, etc.
3. The code can be easily be tracked via Git. Hence, making it quite easy to keep-track of Infra used.
4. built reusable components to automate common tasks

## General Command flow
These are the general steps or lifecycle of a terraform code execution
1. You write your code
2. TF will start executing files in the alphabetical manner, but, if it finds a reference to some other block, then it will wait for the other block to get finish and continue from there.

3. You run init command to initialize everything that is required to get started. It is similar to npm install command
```
terraform init
```
It will start downloading providers, backend, moduels to get you started.

4. You can validate all terraform scripts by using validate command
```
terraform validate
```

5. You can run terraform plan command, to know how and what will terraform script do to your infra. This command basically, compares with the previous state of your infra and make a plan to do necessary changes.
```
terraform plan
```

6. If the plan seems fine, you can run apply command, to commit the changes to your infra
```
terraform apply
```

7. After terraform is done with the application of the plan you asked it to do. It will create a **terraform.tfstate** file. This file will contain all the current state of the infra that has been initialised. It makes sure that any new changes are compared to the previous changes and a proper plan can be derived.

8. **terraform.tfstate.backup** this file contains a reference of the just one version older than terraform.tfstate.

## Components

These are the components used in any terraform project

1. Variables
These are the variables used, throughout the application
You can define variables as
```terraform
variable "variableName" {
  default = "DefaultValue"
  type    = string # type of variable
  description = "Something about the variable"
}
```
then, after initialization, these variables can be used as

```terraform
var.variableName
```
These are the [variable types](https://developer.hashicorp.com/terraform/language/expressions/types)

You can pass in the variables non-interactively with the following command-line arguement
```
terraform plan -var username="Avinash tiwari" -var age="25"
```

We can use system environment variable as variables in our code. You just need to export the variables with the **TF_VAR_** prefix
```
export TF_VAR_username="Tiwari"
```

2. Outputs
If you want to output some variable name or fetch value of some newly created instance, then you can use outputs.
For example, you may want to get the id of the newly created EC2 Instance, then you can use outputs

```terraform
output "outputNameForTerraformContext" {
    value = "This text is using a variable as well ${var.variableName}"
}
```

3. Providers
TF uses third-party providers to facilitate the application of infrastructure. For example, if you want to automate AWS, then you might need AWS provider. TF regitery has thousands of these providers

```
provider "provider-name" {
  config_key = config_value
}

Example

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

```
You can find list of provider [here](https://registry.terraform.io/browse/providers).

4. Terraform block
the Terraform block is used to configure project level settings. Such as, provider required to execute a project. required version of terraform to execute the scripts, etc.

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}
```
5. .tfvars file
the .tfvars file is basically like an environment file to be used to ingest variables via environment file.
the default file name is **terraform.tfvars**. But you can change the name of the file and give it a custom name.
Though, while running the command you need to provide the file name as,

```
terraform plan --var-file=development.tfvars
```

6. Data source
These blocks are used while working with any third-party block. These are used to fetch data from their server. for example, if you are working with AWS and you wanted to fetch the id of the ami-image, then you can use dataSource to fetch it.

You need to refer to the documentation of the plugin to find the name of the service you want to fetch the data for

```
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.image_owner] // get it from AWS
  filter {
    name   = "name"
    values = [var.image_name]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```

7. Dynamic blcoks
These are just like for loop. These are used to generate values around similar type of data
```
dynamic "block_name" {
    for_each = var.ports
    iterator = iterator_variable
    content {
      same_content_key = port.value["name"] # dynamic port values
    }
  }

For Example

dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = port.value["name"]
      from_port   = port.value["port"]
      to_port     = port.value["port"]
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

```
8. backend
TF backends are a way for TF to store tfstate files on some remote location. It secures the state files and can be used for the working of terraform.
```
backend "s3" {
   bucket         = "test-tf-states-1"
   region         = "us-east-2"
   key            = "terraform.tfstate"
   dynamodb_table = "table-name" # table to avoid race-around condition
}
```
9. Modules
TF modules are like packages in NPM. These are reusable packages to be used by the community or by someone from the same team.
To get started with modules, you can just create a folder and write you TF files inside it.
To use the modules, you just have to use the module block
```
module "moduleName" {
    source = "path of the module"
    var1 = "variables required and defined inside/by module"
}
```
You can get output from modules as well. Firstly, the module should have output.tf file in it and it should be returning soemthing to the parent. Then you can use it like this
```
output "customName"{
    value = module.<module-name>.<output-name-inside-module>
}
```
10. Workspaces
workspaces are used to seggregate the workspaces

list workspaces
```
terraform workspace list
```

show current workspace
```
terraform workspace show
```

creating new terraform workspace
```
terraform workspace new dev
```