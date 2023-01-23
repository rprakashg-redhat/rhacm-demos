//GKE Cluster
resource "google_container_cluster" "democluster" {
  name     = "${var.project_id}-gke"
  location = var.region
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.private.name
}

//Linux Node pools
resource "google_container_node_pool" "linux_pool" {
    name               = "linux-pool"
    project            = google_container_cluster.democluster.project
    cluster            = google_container_cluster.democluster.name
    location           = google_container_cluster.democluster.location

    node_config {
        image_type   = "COS_CONTAINERD"
        oauth_scopes = [
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
        ]
        labels = {
            env = var.project_id
        }
        machine_type = "n1-standard-1"
        tags         = ["gke-node", "${var.project_id}-gke"]
        metadata = {
            disable-legacy-endpoints = "true"
        }
    }
}