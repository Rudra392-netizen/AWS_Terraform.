📦 Terraform Functions Demo (Complete Guide)
🧭 Overview
<p> This project demonstrates how to use <b>Terraform Functions</b> in a simple and practical way. We apply these functions in a real-world example by creating an <b>AWS Security Group</b>. </p> <p> The focus is on: </p> <ul> <li>Writing clean Terraform code</li> <li>Using functions in real scenarios</li> <li>Understanding how data is processed inside Terraform</li> </ul>
📁 Project Structure
terraform-functions-demo/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars (optional)
⚙️ Variables (variables.tf)
<h3>1. Environment Name</h3>
variable "env_name" {
  default = "dev"
}
<p><b>Example:</b> dev → used to identify environment</p>
<h3>2. Application Name</h3>
variable "app_name" {
  default = "myapp"
}
<h3>3. Allowed Ports</h3>
variable "allowed_ports" {
  default = [22, 80, 443, 80]
}
<p> ⚠️ Contains duplicate value (80) → will be handled using <b>toset()</b> </p>
<h3>4. Tags Map</h3>
variable "tags_map" {
  default = {
    owner = "team-ai"
    cost  = "ml-project"
  }
}
🧠 Locals (main.tf)
locals {
  env_upper   = upper(var.env_name)
  app_upper   = upper(var.app_name)
  env_app_tag = "${local.env_upper}-${local.app_upper}"
}
🔤 String Function: upper()
<p><b>Purpose:</b> Convert text to uppercase</p> <p><b>Example:</b></p>
upper("dev") → "DEV"
upper("myapp") → "MYAPP"
🔗 String Combination
"${local.env_upper}-${local.app_upper}"
<p><b>Output:</b></p>
DEV-MYAPP
🔐 Resource: AWS Security Group
resource "aws_security_group" "web_sg" {
🏷️ Tags using merge()
tags = merge(var.tags_map, {
  Environment = local.env_upper
  Application = local.app_upper
})
📚 Collection Function: merge()
<p><b>Purpose:</b> Combine two maps</p> <p><b>Input:</b></p>
{
  owner = "team-ai"
  cost  = "ml-project"
}
+
{
  Environment = "DEV"
  Application = "MYAPP"
}
<p><b>Output:</b></p>
{
  owner       = "team-ai"
  cost        = "ml-project"
  Environment = "DEV"
  Application = "MYAPP"
}
🔁 Dynamic Block
dynamic "ingress" {
  for_each = toset(var.allowed_ports)
🔄 Type Conversion: toset()
<p><b>Purpose:</b> Remove duplicates</p> <p><b>Example:</b></p>
[22, 80, 80, 443] → [22, 80, 443]
🔁 Dynamic Rule Creation
content {
  from_port = ingress.value
  to_port   = ingress.value
}
<p><b>Result:</b></p> <ul> <li>Port 22 → Rule created</li> <li>Port 80 → Rule created</li> <li>Port 443 → Rule created</li> </ul>
🔢 Numeric Functions
locals {
  max_port = max(var.allowed_ports...)
  min_port = min(var.allowed_ports...)
}
⚠️ Important: ... Operator
<p> <b>Why needed?</b><br> Because <code>max()</code> and <code>min()</code> do not accept lists directly. </p>
Example
var.allowed_ports = [22, 80, 443]

❌ Wrong:

max(var.allowed_ports)

✅ Correct:

max(var.allowed_ports...)
Output
max → 443
min → 22
📤 Outputs (outputs.tf)
🔤 String Output
output "env_app_upper" {
  value = local.env_app_tag
}
DEV-MYAPP
🔢 Numeric Output
output "max_allowed_port" {
  value = local.max_port
}
443
output "min_allowed_port" {
  value = local.min_port
}
22
📚 Collection Functions
keys()
keys(aws_security_group.web_sg.tags)
["owner", "cost", "Environment", "Application"]
values()
values(aws_security_group.web_sg.tags)
["team-ai", "ml-project", "DEV", "MYAPP"]
🔄 Type Conversion Output
output "allowed_ports_set" {
  value = toset(var.allowed_ports)
}
[22, 80, 443]
▶️ How to Run
terraform init
terraform plan
terraform apply
💡 Key Learnings
<ul> <li>Functions make Terraform dynamic</li> <li><b>upper()</b> helps standardize naming</li> <li><b>merge()</b> is used for tagging (industry standard)</li> <li><b>toset()</b> removes duplicates</li> <li><b>max() / min()</b> require <b>...</b></li> <li>Dynamic blocks reduce repeated code</li> </ul>
🏁 Conclusion
<p> This project gives you a strong foundation in Terraform functions and shows how they are used in real-world DevOps scenarios. </p> <p> You are now ready to: </p> <ul> <li>Write clean Terraform code</li> <li>Use functions confidently</li> <li>Understand real infrastructure logic</li> </ul>