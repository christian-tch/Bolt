resource "aws_organizations_policy" "securityhub-protect" {
  name = "securityhub-protect"
  content = templatefile("${path.module}/policies/securityhub.json",
    {
      RootAccountId = data.aws_organizations_organization.this.master_account_id
    }
  )
}

resource "aws_organizations_policy" "cloudtrail-protect" {
  name = "cloudtrail-protect"
  content = templatefile("${path.module}/policies/cloudtrail.json",
    {
      RootAccountId = data.aws_organizations_organization.this.master_account_id
    }
  )
}

resource "aws_organizations_policy" "cloudtrail-bucket-protect" {
  name = "cloudtrail-bucket-protect"
  content = templatefile("${path.module}/policies/cloudtrail-bucket.json",
    {
      BucketName = "${aws_s3_bucket.this.bucket}"
    }
  )
}