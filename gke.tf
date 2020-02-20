resource "google_container_cluster" "primary" {
  name               = "marcellus-wallace"
  location           = var.gcp_region 
}