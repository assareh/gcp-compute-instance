# Provision a compute instance in GCP
This Terraform configuration provisions a compute instance in Google Cloud Platform.

## Details
By default, this configuration provisions a compute instance from image debian-cloud/debian-9 with machine type t2.micro in the us-west1-b zone of the us-west1 region. But the image, type, zone, and region can all be set with variables.

Note that you need to set provide your GCP credentials per the [provider documentation](https://www.terraform.io/docs/providers/google/guides/provider_reference.html).
