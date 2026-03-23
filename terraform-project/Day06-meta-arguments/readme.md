# 🚀 Terraform Meta-Arguments – Simple Guide

This project demonstrates the use of **Terraform meta-arguments** with simple AWS examples.
It helps beginners understand how Terraform manages resources using features like `count`, `depends_on`, and `lifecycle`.

---

# 📌 What are Meta-Arguments?

Meta-arguments are special arguments in Terraform that control **how resources behave**, not what resources are created.

---

# 📦 Resources Covered in This Project

## 1. 🪣 Create an S3 Bucket

```hcl
resource "aws_s3_bucket" "example" {
  bucket = "rudra-tf-bucket-98188"

  tags = {
    Name        = "My bucket"
    Environment = var.Environment
  }
}
```

---

## 2. 🔢 Using `count` Meta-Argument

```hcl
resource "aws_instance" "simple_ec2" {
  count         = 2
  ami           = "ami-07062e2a343acc423"
  instance_type = var.instance_type[count.index]
  key_name      = "docker"

  monitoring                  = var.monitoring_enables
  associate_public_ip_address = true

  tags = {
    Name = "rudra-simple-ec2"
  }
}
```

### 🧠 Key Concept:

> `count` allows you to create multiple resources.

---

## 3. 🔗 Using `depends_on`

```hcl
resource "aws_s3_bucket" "example2" {
  bucket = "rudra-25050"

  tags = {
    Name        = "demo-bucket"
    Environment = var.Environment
  }
}

resource "aws_instance" "simple_ec22" {
  ami           = "ami-07062e2a343acc423"
  instance_type = "t2.micro"
  key_name      = "docker"

  monitoring                  = var.monitoring_enables
  associate_public_ip_address = true

  tags = {
    Name = "rudra-simple-ec22"
  }

  depends_on = [aws_s3_bucket.example2]
}
```

### 🧠 Key Concept:

> Ensures one resource is created after another.

---

## 4. 🔄 Using `lifecycle` Meta-Argument

```hcl
resource "aws_instance" "example3" {
  ami           = "ami-07062e2a343acc423"
  key_name      = "docker"
  instance_type = "t2.small"

  lifecycle {
    ignore_changes = [tags]
  }

  tags = {
    Name = "rudra-simple-ec3"
  }
}
```

### 🧠 Key Concept:

> Ignores manual changes made outside Terraform.

---

## 5. 🚀 Using `create_before_destroy`

```hcl
resource "aws_instance" "example4" {
  ami           = "ami-07062e2a343acc423"
  key_name      = "docker"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "rudra-zero-downtime"
  }
}
```

### ✅ What this does:

* Creates a new instance before deleting the old one
* Helps avoid downtime

### 🧠 Key Concept:

> Ensures **zero downtime deployments**

---

## 6. 🔒 Using `prevent_destroy`

```hcl
resource "aws_s3_bucket" "example3" {
  bucket = "rudra-protected-bucket"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "protected-bucket"
  }
}
```

### ✅ What this does:

* Prevents accidental deletion of important resources

### 🧠 Key Concept:

> Protects critical infrastructure from being destroyed

---

# ⚙️ Lifecycle Meta-Arguments Summary

| Argument              | Description                             |
| --------------------- | --------------------------------------- |
| create_before_destroy | Create new resource before deleting old |
| prevent_destroy       | Prevent resource deletion               |
| ignore_changes        | Ignore external changes                 |

---

# 🧪 How to Run

```bash
terraform init
terraform plan
terraform apply
```

---

# ⚠️ Important Notes

* Terraform does not block manual changes
* It only manages behavior during `plan` and `apply`
* Use lifecycle rules carefully to avoid confusion

---

# 🎯 Key Learnings

* `count` → create multiple resources
* `depends_on` → control order
* `lifecycle` → control behavior
* Helps build **real-world production infrastructure**

---

# 🚀 Final Thoughts

This project gives a strong foundation for Terraform meta-arguments and prepares you for real DevOps scenarios and interviews.

---
