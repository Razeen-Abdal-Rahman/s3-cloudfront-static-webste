# Static Website Deployment on AWS Using Terraform, S3, and CloudFront

This project automates the deployment of a static website on AWS using Terraform. The infrastructure includes an S3 bucket to store website files, a CloudFront distribution for global content delivery, and appropriate configurations to ensure the website is publicly accessible and secure.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Deployment Steps](#deployment-steps)
  - [Step 1: Clone the Repository](#step-1-clone-the-repository)
  - [Step 2: Configure Terraform](#step-2-configure-terraform)
  - [Step 3: Deploy Infrastructure](#step-3-deploy-infrastructure)
  - [Step 4: Access the Website](#step-4-access-the-website)
- [Cleanup](#cleanup)

## Overview

This project demonstrates how to deploy a static website on AWS using:

- **S3**: For storing website files.
- **CloudFront**: For distributing content with a CDN.
- **Terraform**: To automate the provisioning of resources.

## Prerequisites

To run this project, you will need:

- An **AWS account** with the necessary permissions to create S3 buckets, CloudFront distributions, and other resources.
- **Terraform** installed on your local machine. You can download it from [here](https://www.terraform.io/downloads).
- Basic knowledge of AWS and Terraform.

## Project Structure

```bash
.
├── cloudfront.tf          # Terraform configuration file for Cloudfront distribution
├── s3.tf                  # Terraform configuration file for s3 bucket
├── main.tf                # Terraform configuration file for other resources
├── README.md              # Project documentation (this file)
└── src                    # Folder containing website files
    ├── index.html             # Your main website HTML file
    └── error.html             # Your error page HTML file
```

## Deployment steps

### Step 1: Clone the Repository

First clone the repository to your local machine.

### Step 2: Configure Terraform

open `s3.tf` and change `bucket` to a globally unique name.
check `main.tf` and ensure the AWS `region` in the provider block is correct for your needs.

### Step 3: Deploy Infrastructure

run `terraform init` to initalise the terraform environment.
run `terraform plan` to ensure your AWS account is configured and review the plan ensuring you are happy with what will be deployed.
run `terraform apply` to create the S3 bucket, upload your website files, and set up cloudfront.

### Step 4: Access the Website

Once the deployment is complete, Terraform will output the CloudFront URL. Visit the URL in your browser to see your static website live.

## Cleanup

To prevent incuring any unnesseccary AWS costs, you can destroy the infrastructure when it is no longer needed using `terraform destroy`.
*Note: this command will remove all resources that were created by terraform*
