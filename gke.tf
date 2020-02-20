resource "google_container_cluster" "gke_primary_cluster" {
  name     = "my-gke-cluster"
  location = var.gcp_region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

}

resource "google_container_node_pool" "gke_primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.gke_primary_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "f1.micro"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}