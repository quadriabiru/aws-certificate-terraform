# AWS-CERTIFICATE-TERRAFORM

This repository contains a Terraform configuration for creating and validating an SSL certificate using AWS Certificate Manager (ACM) for a specified domain. The setup is designed to help you secure your web applications by enabling HTTPS.

## Overview

The Terraform code provisions an SSL certificate for a domain and its subdomains, validating ownership via DNS using Amazon Route 53. This is essential for securing communications with users and ensuring data integrity.

### Key Features

- **SSL Certificate Creation**: Generates an SSL certificate for your domain and subdomains.
- **Domain Validation**: Automatically sets up DNS records in Route 53 for certificate validation.
- **Secure Configuration**: Ensures HTTPS is used for secure communication.

## Configuration Files

### main.tf

This is the primary configuration file where the SSL certificate and associated DNS records are defined.

#### Key Resources

- **ACM Certificate**: 
  - Creates an SSL certificate for the specified domain (`root_domain_name`).
  - Supports wildcard subdomains (e.g., `*.example.com`).
  - Uses DNS validation to prove ownership of the domain.

- **Route 53 Zone**: 
  - Retrieves the existing Route 53 hosted zone associated with the domain.
  
- **DNS Record for Validation**:
  - Automatically creates CNAME records in Route 53 needed for domain validation.
  - Ensures that the necessary DNS settings are added for ACM to verify ownership.

- **Certificate Validation**:
  - Validates the certificate using the CNAME records created in the previous step.

### provider.tf

Defines the AWS provider and specifies the required version. Ensure to set the AWS region and provide credentials either through environment variables or a `.tfvars` file.

### variables.tf

Defines variables that can be customized:

- **aws_region**: Specifies the AWS region where resources will be created (e.g., `us-east-1`).
- **access_key**: Your AWS account access key (recommended to use a `.tfvars` file).
- **secret_key**: Your AWS account secret key (recommended to use a `.tfvars` file).
- **root_domain_name**: The main domain name for which you want to create the SSL certificate (e.g., `example.com`).

## Modifying Variables

To customize your setup, you can modify the following variables:

- **`aws_region`**: Set this to your desired AWS region for resource creation.
- **`access_key`** and **`secret_key`**: Input your AWS credentials securely.
- **`root_domain_name`**: Define the root domain name for the SSL certificate. Ensure that this domain is correctly set up in Route 53.

### Impact of Modifications

- Changing the **`root_domain_name`** will result in the creation of an SSL certificate for the new domain and its subdomains. Ensure that the domain exists in Route 53.
- Modifying the **`aws_region`** affects where the resources are provisioned; ensure that the region supports ACM.
- Altering the **DNS validation method** (if implemented) may affect how the domain ownership is verified.

## Usage

1. Update the variables in a `terraform.tfvars` file or set them as environment variables.
2. Initialize Terraform: 
   ```bash
   terraform init
   ```
3. Apply the configuration:
   ```bash
   terraform apply
   ```

This will create the SSL certificate and validate it through the specified DNS records.

## Contributing

Feel free to submit issues or pull requests for enhancements or improvements to this Terraform configuration.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
