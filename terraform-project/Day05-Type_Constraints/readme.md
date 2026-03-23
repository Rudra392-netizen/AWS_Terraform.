# 🚀 Terraform Type Constraints

A clean and beginner-friendly guide to understand **Terraform variable type constraints** with practical examples.

---

## 📌 What are Type Constraints?

Type constraints define **what kind of value a variable can accept** in Terraform.

👉 Simple:
> Type constraint = rule for what data a variable can store

---

## 🎯 Why Use Type Constraints?

- ✅ Prevent wrong inputs  
- ✅ Improve readability  
- ✅ Reduce bugs  
- ✅ Make code production-ready  

---

## 🧩 Types of Type Constraints

---

### 1. 🔤 String

Stores text values.

```hcl
variable "name" {
  type = string
}
```

**Example:**
```hcl
name = "Rudra"
```

---

### 2. 🔢 Number

Stores numeric values.

```hcl
variable "port" {
  type = number
}
```

**Example:**
```hcl
port = 8080
```

---

### 3. 🔘 Boolean

Stores true/false values.

```hcl
variable "monitoring" {
  type = bool
}
```

**Example:**
```hcl
monitoring = true
```

---

### 4. 📋 List

Stores multiple values (ordered).

```hcl
variable "instance_type" {
  type = list(string)
}
```

**Example:**
```hcl
instance_type = ["t2.micro", "t2.medium"]
```

**Usage in resource:**
```hcl
resource "aws_instance" "example" {
  count         = 2
  instance_type = var.instance_type[count.index]
}
```

---

### 5. 🔁 Set

Stores unique values (no duplicates).

```hcl
variable "regions" {
  type = set(string)
}
```

**Example:**
```hcl
regions = ["ap-south-1", "us-east-1"]
```

⚠️ Order is not guaranteed.

---

### 6. 🗂️ Map

Stores key-value pairs.

```hcl
variable "instance_map" {
  type = map(string)
}
```

**Example:**
```hcl
instance_map = {
  dev  = "t2.micro"
  prod = "t2.medium"
}
```

**Usage:**
```hcl
instance_type = var.instance_map["dev"]
```

---

## 🔥 Real DevOps Example

Create 2 EC2 instances with different types:

### variables.tf
```hcl
variable "instance_type" {
  type = list(string)
}
```

### terraform.tfvars
```hcl
instance_type = ["t2.micro", "t2.medium"]
```

### main.tf
```hcl
resource "aws_instance" "example" {
  count         = 2
  ami           = "ami-xxxx"
  instance_type = var.instance_type[count.index]

  tags = {
    Name = "server-${count.index}"
  }
}
```

---

## 📊 Summary Table

| Type   | Description              | Example                  |
|--------|--------------------------|--------------------------|
| string | Text value              | "hello"                 |
| number | Numeric value           | 100                     |
| bool   | true/false              | true                    |
| list   | Ordered values          | ["a","b"]              |
| set    | Unique values           | ["a","b"]              |
| map    | Key-value pairs         | {key="value"}          |

---

## 🧠 Key Takeaways

- Use **string** for text  
- Use **number** for numbers  
- Use **bool** for true/false  
- Use **list** for ordered multiple values  
- Use **set** for unique values  
- Use **map** for key-value data  

---

## 🚀 Final Note

Using type constraints is a **best practice** in Terraform.

👉 It makes your code:
- clean  
- safe  
- production-ready  

---

<p align="center">✨ Happy Learning Terraform ✨</p>
