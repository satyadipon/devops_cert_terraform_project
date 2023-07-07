terraform {
	required_providers {
	    aws = {
	      source  = "hashicorp/aws"
	      version = "~> 4.0"
	    }
    }
}

provider "aws"	{
	region		= "ap-south-1"
	access_key 	= "AKIASV4SV3TE7GEW2YMI"
	secret_key 	= "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"
}