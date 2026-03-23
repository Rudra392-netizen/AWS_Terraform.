<h1 align="center">🚀 Day 02 - Create S3 Bucket Using Terraform</h1>

<hr>

<h2>📌 Overview</h2>

<p>
In Day 02, I created my first real AWS resource using Terraform.
I used Terraform to create an S3 bucket in AWS.
This helped me understand how Terraform talks to AWS and creates cloud resources using code.
</p>

<hr>

<h2>🛠 Tools Used</h2>

<ul>
  <li>Terraform</li>
  <li>AWS CLI</li>
  <li>AWS IAM User Credentials</li>
  <li>Linux (Ubuntu)</li>
</ul>

<hr>

<h2>📂 Files in This Folder</h2>

<ul>
  <li><b>main.tf</b> → Contains provider configuration and S3 bucket resource</li>
  <li><b>.terraform.lock.hcl</b> → Locks the AWS provider version</li>
</ul>

<hr>

<h2>🌍 What is Amazon S3?</h2>

<p>
Amazon S3 (Simple Storage Service) is an object storage service provided by AWS.
It is used to store files like images, videos, backups, logs, and application data.
</p>

<p>
An S3 bucket is like a container where we store our files.
Each bucket name must be globally unique.
</p>

<hr>

<h2>⚙️ Step 1: Configure AWS Credentials</h2>

<p>
Before Terraform can create resources in AWS, it needs authentication.
We configure AWS CLI using:
</p>

<pre>
aws configure
</pre>

<p>
This asks for:
</p>

<ul>
  <li>AWS Access Key</li>
  <li>AWS Secret Key</li>
  <li>Region</li>
  <li>Output format</li>
</ul>

<p>
These credentials are stored locally and Terraform automatically uses them.
</p>

<hr>

<h2>📝 Step 2: Write Terraform Configuration (main.tf)</h2>

<p>
In this file, we define two main things:
</p>

<ul>
  <li>Provider (AWS)</li>
  <li>Resource (S3 bucket)</li>
</ul>

<h3>🔹 Provider Block</h3>

<p>
The provider block tells Terraform which cloud provider we are using.
</p>

Example:

<pre>
provider "aws" {
  region = "ap-south-1"
}
</pre>

<p>
Here we are telling Terraform to use AWS and deploy resources in Mumbai region.
</p>

<h3>🔹 Resource Block</h3>

<p>
The resource block defines what we want to create.
</p>

Example:

<pre>
resource "aws_s3_bucket" "my_bucket" {
  bucket = "rudra-terraform-day02-bucket"
}
</pre>

<p>
Here:
</p>

<ul>
  <li><b>aws_s3_bucket</b> → Type of resource</li>
  <li><b>my_bucket</b> → Local name inside Terraform</li>
  <li><b>bucket</b> → Actual S3 bucket name in AWS</li>
</ul>

<hr>

<h2>🚀 Step 3: Terraform Workflow</h2>

<h3>1️⃣ Initialize Project</h3>

<pre>
terraform init
</pre>

<p>
This downloads the AWS provider plugin.
It also creates the <code>.terraform</code> folder.
</p>

<h3>2️⃣ Validate Configuration</h3>

<pre>
terraform validate
</pre>

<p>
Checks if configuration syntax is correct.
</p>

<h3>3️⃣ See Execution Plan</h3>

<pre>
terraform plan
</pre>

<p>
Shows what Terraform is going to create before actually creating it.
</p>

<h3>4️⃣ Apply Changes</h3>

<pre>
terraform apply
</pre>

<p>
Creates the S3 bucket in AWS.
</p>

<h3>5️⃣ Destroy Infrastructure</h3>

<pre>
terraform destroy
</pre>

<p>
Deletes the S3 bucket.
</p>

<hr>

<h2>📦 What is .terraform.lock.hcl?</h2>

<p>
This file locks the AWS provider version.
It ensures that the same provider version is used every time.
This helps avoid unexpected changes.
</p>

<hr>

<h2>🧠 Concepts I Learned in Day 02</h2>

<ul>
  <li>How Terraform connects with AWS</li>
  <li>What is a provider</li>
  <li>What is a resource block</li>
  <li>How Terraform workflow works (init → plan → apply → destroy)</li>
  <li>Importance of unique S3 bucket names</li>
</ul>

<hr>

<h2>🎯 Objective of Day 02</h2>

<p>
The main goal of Day 02 was to understand how Terraform creates real cloud infrastructure
and how Infrastructure as Code works in real life.
</p>

<hr>

<h3 align="center">✨ Infrastructure as Code in Action ✨</h3>
