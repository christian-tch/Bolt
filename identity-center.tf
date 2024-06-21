
#Retrieving management account id of the organization
data "aws_organizations_organization" "this" {}

#Retrieving SSO iantance id enabled through console

data "aws_ssoadmin_instances" "identity_center" {
}

#Creating SSO Users

resource "aws_identitystore_user" "viewonly" {
  display_name = "viewonly"
  user_name    = "viewonly"
  name {
    given_name  = "Kyrie"
    family_name = "Irving"
  }
  emails {
    value = "givoyiw392@elahan.com"
  }
  identity_store_id = tolist(data.aws_ssoadmin_instances.identity_center.identity_store_ids)[0]
}

resource "aws_identitystore_user" "readonly" {
  display_name = "Readonly"
  user_name    = "readonly"
  name {
    given_name  = "Anthony"
    family_name = "Edwards"
  }
  emails {
    value = "grabappoinnibro-5805@yopmail.com"
  }
  identity_store_id = tolist(data.aws_ssoadmin_instances.identity_center.identity_store_ids)[0]
}

#Creating sso groups

resource "aws_identitystore_group" "viewonly" {
  display_name      = "Viewonly"
  description       = "Viewonly"
  identity_store_id = tolist(data.aws_ssoadmin_instances.identity_center.identity_store_ids)[0]
}


resource "aws_identitystore_group" "readonly" {
  display_name      = "Readonly"
  description       = "Readonly"
  identity_store_id = tolist(data.aws_ssoadmin_instances.identity_center.identity_store_ids)[0]
}

#Assigning sso users to groups 

resource "aws_identitystore_group_membership" "viewonly" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.identity_center.identity_store_ids)[0]
  group_id          = aws_identitystore_group.viewonly.group_id
  member_id         = aws_identitystore_user.viewonly.user_id
}

resource "aws_identitystore_group_membership" "readonly" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.identity_center.identity_store_ids)[0]
  group_id          = aws_identitystore_group.readonly.group_id
  member_id         = aws_identitystore_user.readonly.user_id
}


#Creating permission sets and assigning policies

resource "aws_ssoadmin_permission_set" "viewonly" {
  instance_arn = tolist(data.aws_ssoadmin_instances.identity_center.arns)[0]
  name         = "viewonly"
  description  = "viewonly access"
}

resource "aws_ssoadmin_permission_set" "readonly" {
  instance_arn = tolist(data.aws_ssoadmin_instances.identity_center.arns)[0]
  name         = "ReadOnly"
  description  = "ReadOnly access"
}


resource "aws_ssoadmin_managed_policy_attachment" "viewonly_access_all" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.identity_center.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.viewonly.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "readonly_access_all" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.identity_center.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.readonly.arn
}

#assigning groups to permission sets

resource "aws_ssoadmin_account_assignment" "viewonly" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.identity_center.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.viewonly.arn
  principal_id       = aws_identitystore_group.viewonly.group_id
  principal_type     = "GROUP"

  target_id   = data.aws_organizations_organization.this.master_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "readonly" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.identity_center.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.readonly.arn
  principal_id       = aws_identitystore_group.readonly.group_id
  principal_type     = "GROUP"

  target_id   = data.aws_organizations_organization.this.master_account_id
  target_type = "AWS_ACCOUNT"
}