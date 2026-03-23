<h1 align="center">🚀 Day 03 - Terraform State File Management</h1>

<hr>

<h2>📌 Overview</h2>

<p>
In Day 03, I learned about Terraform state files and remote backend configuration.
State file management is one of the most important concepts in Terraform.
Without understanding state, we cannot use Terraform properly in real projects.
</p>

<hr>

<h2>📂 Files in This Folder</h2>

<ul>
  <li><b>backend.tf</b> → Contains remote backend configuration</li>
  <li><b>.terraform.lock.hcl</b> → Provider dependency lock file</li>
</ul>

<hr>

<h2>📦 What is Terraform State?</h2>

<p>
Terraform state is a file where Terraform stores information about
the infrastructure it has created.
</p>

<p>
This file is usually named:
</p>

<pre>
terraform.tfstate
</pre>

<p>
It keeps a mapping between:
</p>

<ul>
  <li>Terraform configuration</li>
  <li>Real AWS resources</li>
</ul>

<p>
Without the state file, Terraform will not know what resources already exist.
</p>

<hr>

<h2>🧠 Why State File is Important?</h2>

<ul>
  <li>Tracks all created resources</li>
  <li>Improves performance (no need to check AWS every time)</li>
  <li>Helps Terraform plan correct changes</li>
  <li>Prevents duplicate resource creation</li>
</ul>

<p>
In simple words:
State file is Terraform’s memory.
</p>

<hr>

<h2>⚠️ Problem with Local State File</h2>

<p>
By default, Terraform stores the state file locally in the project directory.
</p>

<p>
This creates problems in team environments:
</p>

<ul>
  <li>State file is not shared</li>
  <li>Risk of accidental deletion</li>
  <li>No locking mechanism</li>
  <li>Multiple users can overwrite changes</li>
</ul>

<p>
That is why we use Remote Backend.
</p>

<hr>

<h2>🌍 What is Remote Backend?</h2>

<p>
Remote backend means storing the Terraform state file in a remote location
instead of local system.
</p>

<p>
Common remote backends:
</p>

<ul>
  <li>AWS S3</li>
  <li>Azure Storage</li>
  <li>Terraform Cloud</li>
</ul>

<p>
In this project, I used AWS S3 as backend.
</p>

<hr>

<h2>📝 backend.tf Configuration</h2>

Example:

<pre>
terraform {
  backend "s3" {
    bucket         = "rudra-terraform-state-bucket"
    key            = "day03/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
</pre>

<hr>

<h2>🔍 Explanation of Each Field</h2>

<ul>
  <li><b>bucket</b> → Name of S3 bucket where state file will be stored</li>
  <li><b>key</b> → Path of state file inside bucket</li>
  <li><b>region</b> → AWS region of S3 bucket</li>
  <li><b>dynamodb_table</b> → Used for state locking</li>
  <li><b>encrypt</b> → Enables encryption of state file</li>
</ul>

<hr>

<h2>🔐 What is State Locking?</h2>

<p>
State locking prevents multiple users from modifying infrastructure at the same time.
</p>

<p>
If one person runs <code>terraform apply</code>,
another person must wait.
</p>

<p>
In AWS, state locking is implemented using DynamoDB table.
</p>

<hr>

<h2>🚀 Steps to Configure Remote Backend</h2>

<h3>1️⃣ Create S3 Bucket</h3>

<p>
Create an S3 bucket manually or using Terraform.
</p>

<h3>2️⃣ Create DynamoDB Table</h3>

<p>
Create a DynamoDB table with primary key:
</p>

<pre>
LockID (String)
</pre>

<h3>3️⃣ Add backend.tf File</h3>

<p>
Write the backend configuration inside backend.tf.
</p>

<h3>4️⃣ Run Initialization Again</h3>

<pre>
terraform init
</pre>

<p>
Terraform will migrate local state to S3.
</p>

<hr>

<h2>📦 What Happens After Migration?</h2>

<ul>
  <li>Local state file is removed</li>
  <li>State file stored securely in S3</li>
  <li>Locking enabled via DynamoDB</li>
</ul>

<hr>

<h2>🧠 Important Interview Concepts</h2>

<ul>
  <li>What is terraform.tfstate?</li>
  <li>Why remote backend is required?</li>
  <li>What is state locking?</li>
  <li>How does DynamoDB help in locking?</li>
  <li>What happens if state file is deleted?</li>
</ul>

<hr>

<h2>🎯 Objective of Day 03</h2>

<p>
The goal of Day 03 was to understand how Terraform tracks infrastructure
and how to securely manage state files in real production environments.
</p>

<hr>

<h3 align="center">✨ Mastering Terraform State Management ✨</h3>
