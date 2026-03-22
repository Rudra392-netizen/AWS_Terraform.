📦 Terraform Functions Demo Project
📌 Overview

This project demonstrates how to use Terraform functions in a simple and practical way.

We used:

String functions
Numeric functions
Collection functions
Type conversion functions

👉 The goal is to understand how functions work in real Terraform projects.

📁 Project Structure
terraform-functions-demo/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars (optional)
⚙️ What This Project Does

This project:

Takes input values (environment, app name, ports, tags)
Uses Terraform functions to process them
Creates an AWS Security Group dynamically
🧾 Variables Used (variables.tf)
Variable	Description	Example
env_name	Environment name	dev / prod
app_name	Application name	myapp
allowed_ports	List of ports	[22, 80, 443]
tags_map	Custom tags	{ owner = "team-ai" }
🧠 Functions Used
🔤 1. String Functions
upper()
upper(var.env_name)

👉 Converts text to uppercase

Example:

dev → DEV
🔢 2. Numeric Functions
max() and min()
max(var.allowed_ports...)
min(var.allowed_ports...)

👉 Finds highest and lowest port

Example:

[22, 80, 443] → max = 443, min = 22
📚 3. Collection Functions
merge()
merge(var.tags_map, { Environment = "DEV" })

👉 Combines multiple maps

keys() and values()
keys(map)
values(map)

👉 Extract keys and values from map

🔄 4. Type Conversion Functions
toset()
toset(var.allowed_ports)

👉 Removes duplicate values

Example:

[22, 80, 80] → [22, 80]
⚡ Important Concept
... (Three Dots Operator)
max(var.allowed_ports...)

👉 Converts list into separate values

Example:

[22, 80, 443] → 22, 80, 443
🔁 Dynamic Block Usage
dynamic "ingress" {
  for_each = toset(var.allowed_ports)
}

👉 Automatically creates multiple security rules

Example:

Port 22 → Rule created
Port 80 → Rule created
Port 443 → Rule created
🏷️ Tags Handling
tags = merge(var.tags_map, {
  Environment = "DEV"
  Application = "MYAPP"
})

👉 Combines default + custom tags

📤 Outputs (outputs.tf)
Output	Description
env_app_upper	Combined uppercase name
max_allowed_port	Highest port
min_allowed_port	Lowest port
all_tags_keys	All tag keys
all_tags_values	All tag values
allowed_ports_set	Unique ports
🚀 How to Run
terraform init
terraform plan
terraform apply
💡 Key Learnings
Functions make Terraform dynamic and flexible
toset() helps remove duplicates
merge() is used for tag management (industry standard)
max() and min() need ... for lists
Dynamic blocks reduce repetitive code
🎯 Conclusion

This project shows how to use Terraform functions in a simple and real-world way.

You can now:

Write cleaner Terraform code
Use functions confidently
Understand real DevOps patterns