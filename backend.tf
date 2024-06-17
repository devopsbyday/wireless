terraform {

  backend "s3" {
    bucket         = "devops-terraform-state-xxxxxxxxxxxxxx"
    key            = "wl/exam/state.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "devops-terraform-lock-table-xxxxxxxxxxxx"
  }

}