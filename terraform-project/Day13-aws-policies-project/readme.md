# 🚀 AWS IAM User Management using Terraform (Step-by-Step Project)

## 📌 Project Overview

In this project, I created a system where:

* Multiple IAM users are created automatically
* Users are added to groups based on their department
* Permissions are managed using groups
* Login access is enabled
* Users are forced to change password
* MFA (Multi-Factor Authentication) is enforced

👉 This is how real companies manage users in AWS using automation.

---

# 🎯 What We Built

✔ Create users using CSV file
✔ Create groups (Education, Sales)
✔ Add users to groups automatically
✔ Attach policies to groups
✔ Enable login access
✔ Force password reset
✔ Enforce MFA (security)

---

# 📁 Project Structure

```
.
├── provider.tf
├── main.tf
├── users.csv
└── README.md
```

---

# ⚙️ Prerequisites

* AWS account
* AWS CLI configured
* Terraform installed

---

# 🚀 Step-by-Step Implementation

---

## 🔹 Step 1: Create CSV File (User Data)

👉 This file contains all users

```csv
first_name,last_name,department
Steven,Smith,Education
Jim,Halpert,Sales
```

👉 Simple meaning:

This is the list of users we want to create.

---

## 🔹 Step 2: Configure AWS Provider

```hcl
provider "aws" {
  region = "us-east-1"
}
```

👉 This tells Terraform:

* Use AWS
* Work in this region

---

## 🔹 Step 3: Read CSV File

```hcl
locals {
  users = csvdecode(file("users.csv"))
}
```

👉 Simple meaning:

* Read CSV file
* Store data in variable

---

## 🔹 Step 4: Create IAM Users

```hcl
resource "aws_iam_user" "users" {
  for_each = { for user in local.users : user.first_name => user }

  name = lower("${substr(each.value.first_name, 0, 1)}${each.value.last_name}")

  tags = {
    Department = each.value.department
  }
}
```

👉 Simple meaning:

* Create one user for each row
* Example: Steven Smith → ssmith

---

## 🔹 Step 5: Enable Login Access

```hcl
resource "aws_iam_user_login_profile" "users" {
  for_each = aws_iam_user.users

  user                    = each.value.name
  password_reset_required = true
}
```

👉 Simple meaning:

* Users can login to AWS
* Must change password at first login

---

## 🔹 Step 6: Create Groups

```hcl
resource "aws_iam_group" "education" {
  name = "Education"
}

resource "aws_iam_group" "sales" {
  name = "Sales"
}
```

👉 Simple meaning:

Create teams:

* Education
* Sales

---

## 🔹 Step 7: Add Users to Groups

```hcl
resource "aws_iam_group_membership" "education_team" {
  name  = "education-team"
  group = aws_iam_group.education.name

  users = [
    for user in aws_iam_user.users : user.name
    if user.tags.Department == "Education"
  ]
}
```

👉 Simple meaning:

* Check each user
* If department = Education → add to group

---

## 🔹 Step 8: Attach Policy to Group

```hcl
resource "aws_iam_group_policy_attachment" "education_policy" {
  group      = aws_iam_group.education.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
```

👉 Simple meaning:

* Give permission to group
* All users in group get same access

---

## 🔹 Step 9: Add MFA (Security)

```hcl
resource "aws_iam_policy" "mfa_enforce" {
  name = "enforce-mfa-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Action = "*"
        Resource = "*"
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = "false"
          }
        }
      }
    ]
  })
}
```

👉 Simple meaning:

* If MFA is NOT enabled → block everything

---

## 🔹 Step 10: Attach MFA Policy

```hcl
resource "aws_iam_group_policy_attachment" "education_mfa" {
  group      = aws_iam_group.education.name
  policy_arn = aws_iam_policy.mfa_enforce.arn
}
```

👉 Simple meaning:

* All users must enable MFA

---

# 🔄 How User Login Works (Example: Steven)

---

## Step 1: Admin creates user

Terraform creates:

```
Username: ssmith
```

---

## Step 2: Admin sets password

Admin sets:

```
Password: Temp@1234
```

---

## Step 3: Steven logs in

```
Username: ssmith
Password: Temp@1234
```

---

## Step 4: Change password

AWS forces:

👉 Steven must create new password

---

## Step 5: Try to access AWS

❌ Access denied (MFA not enabled)

---

## Step 6: Enable MFA

* Go to Security Credentials
* Enable MFA
* Scan QR code

---

## Step 7: Login again

```
Username: ssmith
Password: new password
+ MFA code
```

---

## 🎯 Final Result

✔ Login works
✔ Access works
✔ Secure system

---

# ⚠️ Problems Faced

* Understanding `for_each`
* CSV format issues
* Typo errors in Terraform
* MFA confusion

---

# 💡 Key Learnings

* Automation using Terraform
* Group-based access control
* Security using MFA
* Real-world IAM setup

---

# 🏆 Conclusion

This project shows how to:

* Manage users at scale
* Automate IAM using Terraform
* Apply real-world security practices

👉 This is a beginner-to-intermediate level DevOps project.

---

# 🚀 Future Improvements

* Add more groups (Managers, Engineers)
* Use S3 backend
* Add IAM roles
* Automate password generation

---

# 🎉 Final Note

This project helped me understand:

👉 How companies actually manage users in AWS using automation.

---
