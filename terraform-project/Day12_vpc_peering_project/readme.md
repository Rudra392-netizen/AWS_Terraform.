# 🚀 AWS VPC Peering Project using Terraform

## 📌 Project Overview

In this project, I created a complete AWS networking setup using Terraform.

The main goal was to:

* Create two VPCs
* Create public and private subnets
* Configure Internet Gateway
* Setup Route Tables
* Establish VPC Peering
* Enable communication between both VPCs

This project helped me understand AWS networking in a practical way.

---

## 🏗️ Architecture

👉 Add your architecture diagram here

---

## ⚙️ Technologies Used

* AWS (VPC, EC2, Networking)
* Terraform

---

## 📂 Project Structure

👉 You can organize your files like this:

```
.
├── main.tf
├── variables.tf (optional)
├── outputs.tf (optional)
```

---

## 🧠 Key Concepts Covered

* VPC (Virtual Private Cloud)
* CIDR Blocks
* Public and Private Subnets
* Internet Gateway
* Route Tables
* Route Table Association
* VPC Peering
* Networking Debugging

---

# 🧾 Terraform Code with Explanation

---

## 🔹 1. Create VPCs

```hcl
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "vpc1" }
}

resource "aws_vpc" "vpc2" {
  cidr_block = "10.1.0.0/16"
  tags       = { Name = "vpc2" }
}
```

### 🔍 Explanation

* `cidr_block` → defines IP range of VPC
* vpc1 → 10.0.0.0/16
* vpc2 → 10.1.0.0/16

👉 These are two separate networks.

---

## 🔹 2. Create Subnets

```hcl
resource "aws_subnet" "vpc1_public" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  tags                    = { Name = "vpc1_public" }
}

resource "aws_subnet" "vpc1_private" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-2b"
  tags                    = { Name = "vpc1_private" }
}

resource "aws_subnet" "vpc2_public" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2c"
  tags                    = { Name = "vpc2_public" }
}
```

### 🔍 Explanation

* Subnet = small part of VPC
* Public subnet → gets public IP
* Private subnet → no public IP

👉 vpc1 has both public & private subnet
👉 vpc2 has only public subnet

---

## 🔹 3. Internet Gateway

```hcl
resource "aws_internet_gateway" "vpc1_igw" {
  vpc_id = aws_vpc.vpc1.id
  tags   = { Name = "vpc1-IGW" }
}

resource "aws_internet_gateway" "vpc2_igw" {
  vpc_id = aws_vpc.vpc2.id
  tags   = { Name = "VPC2_IGW" }
}
```

### 🔍 Explanation

Internet Gateway allows VPC to connect to internet.

👉 Without this, no internet access.

---

## 🔹 4. Route Tables

```hcl
resource "aws_route_table" "vpc1_public_rt" {
  vpc_id = aws_vpc.vpc1.id
  tags   = { Name = "VPC1_public-RT" }
}

resource "aws_route" "vpc1_public_internet" {
  route_table_id         = aws_route_table.vpc1_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc1_igw.id
}

resource "aws_route_table" "vpc1_private_rt" {
  vpc_id = aws_vpc.vpc1.id
  tags   = { Name = "VPC1_private-RT" }
}

resource "aws_route_table" "vpc2_public_rt" {
  vpc_id = aws_vpc.vpc2.id
  tags   = { Name = "VPC2_public_RT" }
}

resource "aws_route" "vpc2_public_internet" {
  route_table_id         = aws_route_table.vpc2_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc2_igw.id
}
```

### 🔍 Explanation

Route table decides where traffic goes.

```text
0.0.0.0/0 → Internet Gateway
```

👉 Means: send all traffic to internet

👉 Only public subnet uses this route

---

## 🔹 5. Route Table Association

```hcl
resource "aws_route_table_association" "vpc1_public_access" {
  subnet_id      = aws_subnet.vpc1_public.id
  route_table_id = aws_route_table.vpc1_public_rt.id
}

resource "aws_route_table_association" "vpc1_private_access" {
  subnet_id      = aws_subnet.vpc1_private.id
  route_table_id = aws_route_table.vpc1_private_rt.id
}

resource "aws_route_table_association" "vpc2_public_access" {
  subnet_id      = aws_subnet.vpc2_public.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}
```

### 🔍 Explanation

This connects subnet with route table.

👉 Without this, routing will not work.

---

## 🔹 6. VPC Peering

```hcl
resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = aws_vpc.vpc1.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true
  tags        = { Name = "VPC1-VPC2-peering" }
}
```

### 🔍 Explanation

* Connects vpc1 and vpc2
* Enables private communication

👉 No internet used

---

## 🔹 7. Peering Routes

```hcl
resource "aws_route" "vpc1_private_to_vpc2" {
  route_table_id            = aws_route_table.vpc1_private_rt.id
  destination_cidr_block    = aws_vpc.vpc2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "vpc2_public_to_vp1" {
  route_table_id            = aws_route_table.vpc2_public_rt.id
  destination_cidr_block    = aws_vpc.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
```

### 🔍 Explanation

This is the **most important step**.

👉 It tells AWS:

* How to send traffic to another VPC

Without this:
❌ Communication will not work

---

## 🧪 Testing

```bash
ping <private-ip>
```

👉 Use private IP only

---

## ❌ Issue Faced

* Ping was not working between VPCs
* Same VPC → working
* Different VPC → not working

---

## 🔍 Debugging

I checked:

* Peering → Active
* Route tables → Correct
* Subnet association
* Security groups

Finally fixed the issue and ping worked.

---

## 🧠 Key Learnings

* Routing is the most important part
* VPC Peering needs manual configuration
* Public vs Private subnet difference
* Always debug step by step

---

## 🚀 Future Improvements

* Add NAT Gateway
* Improve security
* Build production architecture

---

## 💬 Author

Rudra Pratap Singh
DevOps & Cloud Learner 🚀
