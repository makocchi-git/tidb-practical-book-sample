terraform {
  required_providers {
    tidbcloud = {
      source  = "tidbcloud/tidbcloud"
      version = "~> 0.3.0"
    }
  }
}

data "tidbcloud_projects" "my_projects" {
  page_size = 10
}

locals {
  project_name = "default_project"
  project_id = {
    value = element([for s in data.tidbcloud_projects.my_projects.items : s.id if s.name == local.project_name], 0)
  }
}

resource "tidbcloud_cluster" "my_serverless_cluster" {
  project_id     = local.project_id.value
  name           = "cluster-from-terraform"
  cluster_type   = "DEVELOPER"
  cloud_provider = "AWS"
  region         = "ap-northeast-1"
  config = {
    root_password = "my_secret_password"
  }
}

output "connection_strings" {
  value = lookup(tidbcloud_cluster.my_serverless_cluster.status, "connection_strings")
}