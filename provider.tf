provider "aws" {
  version = "~> 2.11"
  region  = var.region
  profile = var.profile_name

  # assume_role {
  #   role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  # }
}