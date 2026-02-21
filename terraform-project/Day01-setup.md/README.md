<h1 align="center">🚀 Day 01 - Terraform Setup & Basics</h1>

<hr>

<h2>📌 Overview</h2>

<p>
This folder contains the setup and basic configuration of Terraform.
In Day 01, I learned how to install Terraform, initialize a project,
and create my first basic Terraform configuration file.
</p>

<hr>

<h2>🛠 Tools Used</h2>

<ul>
  <li>Terraform</li>
  <li>AWS CLI</li>
  <li>Git & GitHub</li>
  <li>Linux (Ubuntu)</li>
</ul>

<hr>

<h2>⚙️ Terraform Installation (Official Method)</h2>

<p>
In this section, Terraform is installed using the official HashiCorp APT repository.
This is the recommended and production-ready method.
</p>

<h3>Step 1: Update System and Install Required Packages</h3>

<pre>
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
</pre>

<p>
This installs required dependencies like:
</p>

<ul>
  <li><b>gnupg</b> → For verifying security keys</li>
  <li><b>software-properties-common</b> → For managing repositories</li>
  <li><b>curl</b> → For secure downloads</li>
</ul>

<h3>Step 2: Add HashiCorp GPG Key</h3>

<pre>
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
</pre>

<p>
This adds HashiCorp’s official security key to the system.
</p>

<h3>Step 3: Add Official HashiCorp Repository</h3>

<pre>
sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
</pre>

<p>
This command tells Ubuntu to download Terraform from HashiCorp’s official repository.
</p>

<h3>Step 4: Install Terraform</h3>

<pre>
sudo apt-get update
sudo apt-get install terraform
</pre>

<h3>Step 5: Verify Installation</h3>

<pre>
terraform -version
</pre>

<p>
If installation is successful, the Terraform version will be displayed.
</p>

<hr>

<h2>📂 Files in This Folder</h2>

<ul>
  <li><b>main.tf</b> → Contains basic Terraform configuration</li>
  <li><b>.terraform.lock.hcl</b> → Provider dependency lock file</li>
  <li><b>Day01-setup.md</b> → Documentation for setup process</li>
</ul>

<hr>

<h2>⚙️ What I Learned</h2>

<ul>
  <li>How to install Terraform</li>
  <li>How to verify installation using <code>terraform --version</code></li>
  <li>How to write a basic <code>main.tf</code> file</li>
  <li>How to run <code>terraform init</code></li>
  <li>Understanding the purpose of <code>.terraform.lock.hcl</code></li>
</ul>

<hr>

<h2>📜 Basic Terraform Commands Used</h2>

<pre>
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
</pre>

<hr>

<h2>📖 Explanation</h2>

<p>
<code>terraform init</code> initializes the project and downloads required providers.
</p>

<p>
<code>terraform plan</code> shows what changes Terraform will make before applying.
</p>

<p>
<code>terraform apply</code> creates the infrastructure.
</p>

<p>
<code>terraform destroy</code> deletes the created infrastructure.
</p>

<hr>

<h2>🎯 Objective of Day 01</h2>

<p>
The main goal of Day 01 was to understand the Terraform workflow 
and how Terraform interacts with cloud providers.
</p>

<hr>

<h3 align="center">✨ Terraform Learning Journey Begins Here ✨</h3>
