<h1 align="center">🚀 Terraform EC2 Project using Data Sources</h1>

<p align="center">
  <b>Provision an EC2 instance dynamically using existing AWS infrastructure</b>
</p>

---

<h2>📌 Project Overview</h2>

<p>
This project demonstrates how to use <b>Terraform Data Sources</b> to fetch existing AWS resources 
like AMI, VPC, Subnet, and Security Group, and then create a new EC2 instance dynamically.
</p>

<ul>
  <li>✅ No hardcoding of AMI or subnet</li>
  <li>✅ Uses existing AWS infrastructure</li>
  <li>✅ Dynamic instance type using <code>lookup()</code></li>
  <li>✅ Clean and modular Terraform structure</li>
</ul>

---

<h2>🏗️ Architecture</h2>

---

<h2>⚙️ Project Structure</h2>

<pre>
.
├── main.tf
├── variables.tf
├── output.tf
├── provider.tf
</pre>

---

<h2>📂 File Explanation</h2>

---

<h3>🔹 variables.tf</h3>

<p>
This file is used to define <b>input variables</b> for the Terraform project.
It makes the configuration <b>dynamic and reusable</b>.
</p>

<ul>
  <li><b>environment</b> → Defines environment (dev/prod)</li>
  <li><b>instance_type</b> → Map to select instance type based on environment</li>
</ul>

<img width="543" height="428" alt="Screenshot 2026-03-23 184536" src="https://github.com/user-attachments/assets/af656878-77b1-4361-86fd-5cdabfc81246" />



---

<h3>🔹 main.tf</h3>

<p>
This is the <b>core file</b> where all infrastructure logic is written.
</p>

<ul>
  <li>Fetch latest AMI using <b>data source</b></li>
  <li>Fetch default VPC</li>
  <li>Fetch subnets from VPC</li>
  <li>Fetch existing security group</li>
  <li>Use <code>lookup()</code> to decide instance type</li>
  <li>Create EC2 instance using fetched values</li>
</ul>
<img width="721" height="946" alt="Screenshot 2026-03-23 184451" src="https://github.com/user-attachments/assets/4d153494-d299-4897-83c4-f71f1cfca2d1" />


---

<h3>🔹 output.tf</h3>

<p>
This file is used to display <b>important output values</b> after Terraform execution.
</p>

<ul>
  <li>Shows selected instance type</li>
  <li>Displays AMI ID used</li>
  <li>Displays subnet ID</li>
  <li>Displays security group name</li>
</ul>
<img width="985" height="459" alt="Screenshot 2026-03-23 184510" src="https://github.com/user-attachments/assets/03201bda-a8e6-42e1-9a61-8f107515eaec" />


---

<h3>🔹 provider.tf</h3>

<p>
This file defines the <b>AWS provider configuration</b>.
</p>

<ul>
  <li>Specifies AWS region</li>
  <li>Allows Terraform to interact with AWS APIs</li>
</ul>

<img width="543" height="428" alt="Screenshot 2026-03-23 184536" src="https://github.com/user-attachments/assets/560cc829-fb2d-4527-9c82-8c88c2487af2" />


---

<h2>🧠 How It Works</h2>

<ol>
  <li>Terraform fetches latest AMI from AWS</li>
  <li>Gets default VPC</li>
  <li>Fetches subnets inside that VPC</li>
  <li>Selects one subnet using <code>ids[0]</code></li>
  <li>Fetches default security group</li>
  <li>Uses <code>lookup()</code> for instance type</li>
  <li>Creates EC2 instance using these values</li>
</ol>

---

<h2>🎯 Key Concepts Used</h2>

<ul>
  <li><b>Data Sources</b> → Fetch existing AWS resources</li>
  <li><b>lookup()</b> → Dynamic value selection</li>
  <li><b>Variables</b> → Make code reusable</li>
  <li><b>Locals</b> → Store computed values</li>
  <li><b>Outputs</b> → Display results</li>
</ul>

---

<h2>⚠️ Important Notes</h2>

<ul>
  <li><code>aws_subnets</code> returns a list → use <code>ids[0]</code></li>
  <li>Terraform creates a <b>new EC2 instance</b></li>
  <li>Existing infrastructure is only <b>read using data sources</b></li>
</ul>

---

<h2>🚀 How to Run</h2>

<pre><code>
terraform init
terraform plan
terraform apply
</code></pre>

---

<h2>🎤 Interview Key Points</h2>

<ul>
  <li>Difference between <code>resource</code> and <code>data</code></li>
  <li>Why avoid hardcoding AMI</li>
  <li>Use of <code>lookup()</code></li>
  <li>Difference between <code>aws_subnet</code> and <code>aws_subnets</code></li>
</ul>

---

<h2 align="center">👨‍💻 Author</h2>

<p align="center">
  <b>Rudra Pratap Singh</b><br>
  DevOps | Terraform | Cloud Enthusiast
</p>
