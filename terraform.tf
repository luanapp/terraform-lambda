terraform {
    required_version = "~> 1.0.2"

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }

    backend "s3" {
        bucket =  "luana-pimentel-terraform-state"
        key    =  "state.json"
        region =  "sa-east-1"
        encrypt = true
    }
}

provider "aws" {
    region = "sa-east-1"
}