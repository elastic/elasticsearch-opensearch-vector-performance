provider "google" {
  project = "benchmark-project"           # project id, not the name
  region  = "us-central"              	  # the region
  credentials = file("credentials.json")  # your service account credentials
}

resource "google_container_cluster" "my_cluster" {
  name               = "es-os-benchmarks"  
  location           = "us-central1-a"

  remove_default_node_pool = true                
  initial_node_count       = 1
}


resource "google_container_node_pool" "elasticsearch_nodes_32cpu" {
  name       = "elasticsearch-nodepool-32"
  cluster    = google_container_cluster.my_cluster.id
  node_count = 3

  node_config {
    machine_type = "e2-standard-32"
    disk_size_gb = 25
  }
}

resource "google_container_node_pool" "kibana_nodes_2cpu" {
  name       = "elasticsearch-nodepool-2"
  cluster    = google_container_cluster.my_cluster.id
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 10
  }
}


resource "google_container_node_pool" "opensearch_nodes_32cpu" {
  name       = "opensearch-nodepool-32"
  cluster    = google_container_cluster.my_cluster.id
  node_count = 3

  node_config {
    machine_type = "e2-standard-32"
    disk_size_gb = 25
  }
}

resource "google_container_node_pool" "dashboards_nodes_2cpu" {
  name       = "dashboards-nodepool-2"
  cluster    = google_container_cluster.my_cluster.id
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 10
  }
}

resource "google_container_node_pool" "rally_nodes" {
  name       = "rally-nodes"
  cluster    = google_container_cluster.my_cluster.id
  node_count = 2

  node_config {
    machine_type = "e2-standard-4"
    disk_size_gb = 10
  }
}

