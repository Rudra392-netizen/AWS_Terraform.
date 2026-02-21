<h1 align="center">🚀 Day 04 - Terraform Variables & Project Structure</h1>

<hr>

<h2>📌 Overview</h2>

<p>
In Day 04, I learned how to use Variables and Outputs in Terraform.
I also organized my Terraform code into multiple files like provider.tf, variables.tf,
main.tf, output.tf, and backend.tf.
</p>

<p>
This is the proper way of writing Terraform code in real-world projects.
</p>

<hr>

<h2>📂 Files in This Folder</h2>

<ul>
  <li><b>provider.tf</b> → Contains cloud provider configuration</li>
  <li><b>variables.tf</b> → Contains all input variable declarations</li>
  <li><b>main.tf</b> → Contains resource definitions</li>
  <li><b>output.tf</b> → Contains output values</li>
  <li><b>backend.tf</b> → Remote backend configuration</li>
  <li><b>.terraform.lock.hcl</b> → Provider version lock file</li>
</ul>

<hr>

<h2>🧠 Why We Use Multiple Files?</h2>

<p>
Terraform automatically reads all .tf files in a folder.
We split files to make code:
</p>

<ul>
  <li>Clean</li>
  <li>Organized</li>
  <li>Easy to manage</li>
  <li>Production-ready</li>
</ul>

<p>
This structure is used in real DevOps projects.
</p>

<hr>

<h2>🌍 provider.tf</h2>

<p>
This file defines which cloud provider we are using.
</p>

Example:

<pre>
provider "aws" {
  region = var.aws_region
}
</pre>

<p>
Here we are using a variable instead of hardcoding region.
This makes the code reusable.
</p>

<hr>

<h2>📥 variables.tf</h2>

<p>
Variables are like inputs in Terraform.
They make our code dynamic and reusable.
</p>

Example:

<pre>
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
</pre>

<h3>🔍 Explanation</h3>

<ul>
  <li><b>variable</b> → Keyword to declare variable</li>
  <li><b>description</b> → Explains purpose</li>
  <li><b>type</b> → Defines data type (string, number, bool, list, map)</li>
  <li><b>default</b> → Optional default value</li>
</ul>

<p>
If no default is given, Terraform will ask for value during apply.
</p>

<hr>

<h2>📦 main.tf</h2>

<p>
This file contains the actual infrastructure resources.
</p>

Example:

<pre>
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}
</pre>

<p>
Here we are using variable instead of hardcoding bucket name.
This makes the configuration reusable.
</p>

<hr>

<h2>📤 output.tf</h2>

<p>
Output values show important information after resource creation.
</p>

Example:

<pre>
output "bucket_arn" {
  description = "ARN of the created bucket"
  value       = aws_s3_bucket.my_bucket.arn
}
</pre>

<p>
After running <code>terraform apply</code>, this value will be displayed.
</p>

<h3>Why Outputs Are Important?</h3>

<ul>
  <li>To display important resource details</li>
  <li>To pass values between modules</li>
  <li>Used in CI/CD pipelines</li>
</ul>

<hr>

<h2>🌍 backend.tf</h2>

<p>
This file stores remote backend configuration.
State file is stored in S3 instead of local system.
</p>

Example:

<pre>
terraform {
  backend "s3" {
    bucket         = "rudra-terraform-state-bucket"
    key            = "day04/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
</pre>

<p>
This ensures:
</p>

<ul>
  <li>State file is stored securely in S3</li>
  <li>State locking via DynamoDB</li>
  <li>Team collaboration is safe</li>
</ul>

<hr>

<h2>🚀 Complete Terraform Workflow</h2>

<h3>1️⃣ Initialize</h3>

<pre>
terraform init
</pre>

<p>
Downloads providers and configures backend.
</p>

<h3>2️⃣ Validate</h3>

<pre>
terraform validate
</pre>

<p>
Checks configuration syntax.
</p>

<h3>3️⃣ Plan</h3>

<pre>
terraform plan
</pre>

<p>
Shows execution plan.
</p>

<h3>4️⃣ Apply</h3>

<pre>
terraform apply
</pre>

<p>
Creates infrastructure.
</p>

<h3>5️⃣ Destroy</h3>

<pre>
terraform destroy
</pre>

<p>
Deletes infrastructure.
</p>

<hr>

<h2>🧠 Important Concepts Learned</h2>

<ul>
  <li>What are Terraform variables</li>
  <li>How to use variable types</li>
  <li>Difference between default and required variables</li>
  <li>What are outputs</li>
  <li>How Terraform reads multiple .tf files automatically</li>
  <li>How backend configuration works</li>
</ul>

<hr>

<h2>🎯 Objective of Day 04</h2>

<p>
The goal of Day 04 was to write reusable and production-ready Terraform code
by using variables, outputs, proper file structure, and remote backend.
</p>

<hr>

<h3 align="center">✨ Writing Clean & Reusable Infrastructure Code ✨</h3>
