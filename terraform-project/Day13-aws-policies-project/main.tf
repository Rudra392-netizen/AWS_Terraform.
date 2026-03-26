#First we need to decode the code, means we need to convert csv into terraform-readable-format
locals {
  users = csvdecode(file("users.csv"))
}

#Now we will create the users automatically
resource "aws_iam_user" "users" {
  for_each = { for user in local.users : user.first_name => user }
  name     = "${each.value.first_name}-${each.value.last_name}"

  tags = {
    Department = each.value.department
  }
}

#Give login access to the users
resource "aws_iam_user_login_profile" "users" {
  for_each                = aws_iam_user.users
  user                    = each.value.name
  password_reset_required = true
}

#Now create the groups for the user
resource "aws_iam_group" "education" {
  name = "Education"
}

#create similar group for sales
resource "aws_iam_group" "sales" {
  name = "Sales"
}

#Add all the users which belongs to the education_group
resource "aws_iam_group_membership" "education_team" {
  name  = "education-team"
  group = aws_iam_group.education.name
  users = [
    for user in aws_iam_user.users : user.name
    if user.tags.Department == "Education"
  ]
}

#Add all the users which belongs to the sales_group
resource "aws_iam_group_membership" "sales_team" {
  name  = "Sales-team"
  group = aws_iam_group.sales.name
  users = [
    for user in aws_iam_user.users : user.name
    if user.tags.Department == "Sales"
  ]
}

#Now attach policies to the Education group
resource "aws_iam_group_policy_attachment" "education_policy" {
  group      = aws_iam_group.education.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

#Now attach policies to the Sales group
resource "aws_iam_group_policy_attachment" "sales_policy" {
  group      = aws_iam_group.sales.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

#create a MFA policy for the users belong to the group Education
resource "aws_iam_policy" "mfa_enforce" {
  name = "enforce-mfa-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Deny"
        Action   = "*"
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

#Now attach the policy to the Education group
resource "aws_iam_group_policy_attachment" "educatoin_mfa" {
  group      = aws_iam_group.education.name
  policy_arn = aws_iam_policy.mfa_enforce.arn
}

#Now attach the MFA policy for the sales group
resource "aws_iam_group_policy_attachment" "sales_mfa" {
  group      = aws_iam_group.sales.name
  policy_arn = aws_iam_policy.mfa_enforce.arn
}
