// For this task, we will use Google Cloud Platform as a basis
// We will not be using any pre-built modules to assist us in the task
// This suggests that we will approach the result of this assignment in a different way, using only the officially provided resources for the provider

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.42.1"
    }
  }
  required_version = ">= 0.14"
}

###-------PROVIDERS-------###

# NOTE! The simplicity of the task does not assume we will be using a separate variables.tf or terraform.tfvars file.

provider "google" {
  project = "production-env"
  credentials = "The secret key is usually quite long"
}

variable "project_id" {
    default = "production-env"
  
}

resource "google_project_iam_custom_role" "custom-role" {
  role_id     = "CustomRole"
  title       =  "EmptyRole"
  description = "task role"
  permissions = []
  project = var.project_id

}

resource "google_project_iam_binding" "project" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/CustomRole"

  members = [
    "user:jane@example.com",
    "user:jane@example.com"
  ]

// Optionally add a condition

#   condition {
#     title       = "expires_after_2019_12_31"
#     description = "Expiring at midnight of 2019-12-31"
#     expression  = "request.time < timestamp(\"2020-01-01T00:00:00Z\")"
#   }

}

// This is an alternative, far simple way of achieving the same task.

#  resource "google_project_iam_member" "custom-role-principals" {
#    role     = "projects/${var.project_id}/roles/CustomRole"
#    project  = var.project_id
#    member   = [
#     "exampleuser@example.com",
#     "examppleuser2@example.com"
#     ]
#  }