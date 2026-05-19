terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://192.168.1.35:8006/api2/json"
  pm_api_token_id     = "terraform@pam!terraform"
  pm_api_token_secret = "bdcbd933-8cbf-4c6c-be85-41b0b8f74ba3"
  pm_tls_insecure     = true
  pm_parallel         = 4
}

module "k3s_cluster" {
  source        = "../../../modules/k3s-cluster"
  cluster_name  = "empty-k3s-may19"
  proxmox_nodes = ["machine-1"]
  template_name = "debian-k3s"
  master_count  = 1
  worker_count  = 0
  cores         = 2
  memory        = 2048
  disk_size     = 20
}
