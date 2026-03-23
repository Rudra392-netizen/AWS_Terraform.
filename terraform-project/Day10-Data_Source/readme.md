<h1 align="center">📦 Terraform Data Sources – Complete Guide</h1>

<p align="center">
  <b>Learn how to use Terraform Data Sources in a simple, practical, and interview-ready way 🚀</b>
</p>

---

<h2>📌 Introduction</h2>

<p>
A <b>Data Source</b> in Terraform is used to fetch information about <b>existing infrastructure</b> 
from a cloud provider like AWS instead of creating new resources.
</p>

<ul>
  <li>✅ Makes code dynamic</li>
  <li>✅ Avoids hardcoding</li>
  <li>✅ Uses existing infrastructure</li>
  <li>✅ Production-ready approach</li>
</ul>

---

<h2>⚖️ Resource vs Data Source</h2>

<table>
  <tr>
    <th>Feature</th>
    <th>Resource</th>
    <th>Data Source</th>
  </tr>
  <tr>
    <td>Purpose</td>
    <td>Create infrastructure</td>
    <td>Read existing infrastructure</td>
  </tr>
  <tr>
    <td>Keyword</td>
    <td><code>resource</code></td>
    <td><code>data</code></td>
  </tr>
  <tr>
    <td>Example</td>
    <td>Create EC2</td>
    <td>Fetch AMI, VPC</td>
  </tr>
</table>

---

<h2>🎯 Why Use Data Sources?</h2>

<ul>
  <li>❌ Avoid hardcoding AMI IDs</li>
  <li>🔄 Automatically fetch latest values</li>
  <li>🌐 Use existing VPC, Subnet, Security Group</li>
  <li>🏭 Follow real industry practices</li>
</ul>

---

<h2>🧠 Key Concept</h2>

<p align="center">
  <b>👉 Data source fetches ONLY what you ask for — nothing more, nothing less.</b>
</p>

---

<h2>🚀 Practical Example</h2>

<p><b>Goal:</b> Create an EC2 instance using existing infrastructure</p>

<ul>
  <li>Latest AMI</li>
  <li>Existing VPC</li>
  <li>Existing Subnet</li>
  <li>Existing Security Group</li>
  <li>Dynamic instance type using <code>lookup()</code></li>
</ul>

---

<h2>📂 Terraform Configuration</h2>

<pre>
<code>
# VARIABLES
variable "environment" {
  type    = string
  default = "dev"
}

variable "instance_map" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t2.large"
  }
}

# DATA SOURCES

data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  owners = ["amazon"]
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  name = "default"
}

# LOCALS
locals {
  instance_type = lookup(var.instance_map, var.environment, "t2.micro")
}

# RESOURCE
resource "aws_instance" "app" {
  ami                    = data.aws_ami.latest.id
  instance_type          = local.instance_type
  subnet_id              = data.aws_subnets.subnets.ids[0]
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "${var.environment}-server"
  }
}
</code>
</pre>

---

<h2>🔍 Explanation (Very Simple)</h2>

<ul>
  <li><b>AMI</b> → Fetch latest OS image automatically</li>
  <li><b>VPC</b> → Get default network</li>
  <li><b>Subnets</b> → Get list of subnets and pick one</li>
  <li><b>Security Group</b> → Use existing firewall rules</li>
  <li><b>lookup()</b> → Select instance type based on environment</li>
</ul>

---

<h2>⚠️ Common Errors & Fixes</h2>

<h3>❌ Multiple Subnets Error</h3>

<pre><code>multiple EC2 Subnets matched</code></pre>

<p>✔ Fix:</p>

<pre><code>subnet_id = data.aws_subnets.subnets.ids[0]</code></pre>

---

<h3>❌ Invalid Subnet ID</h3>

<pre><code>InvalidSubnetID.NotFound</code></pre>

<p>✔ Fix: Ensure correct subnet ID (not region)</p>

---

<h3>❌ Undeclared Resource</h3>

<pre><code>Reference to undeclared resource</code></pre>

<p>✔ Fix: Check correct data source name</p>

---

<h2>💡 Best Practices</h2>

<ul>
  <li>✅ Never hardcode AMI IDs</li>
  <li>✅ Always use filters</li>
  <li>✅ Use tags for better selection</li>
  <li>✅ Prefer <code>aws_subnets</code> over <code>aws_subnet</code></li>
</ul>

---

<h2>🎤 Interview Questions</h2>

<ul>
  <li><b>What is a data source?</b> → Fetch existing resources</li>
  <li><b>Why use it?</b> → Avoid hardcoding</li>
  <li><b>Resource vs Data?</b> → Create vs Read</li>
</ul>

---

<h2>🧠 Final Summary</h2>

<p align="center">
  <b>
    data → fetch existing resources <br>
    resource → create new resources <br><br>
    🚀 Data sources make Terraform dynamic and production-ready
  </b>
</p>

---

<h2 align="center">🚀 Author</h2>

<p align="center">
  <b>Rudra Pratap Singh</b><br>
  DevOps | Terraform | Cloud Enthusiast
</p>