terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "multicloud-provisioning-demo"
    workspaces {
      name = "gcp-compute-instance-dev"
    }
  }
}
