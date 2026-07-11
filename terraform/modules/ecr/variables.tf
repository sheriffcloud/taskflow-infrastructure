variable "environment" {
    description = "The environment for the deployment (e.g., dev, staging, prod)"
    type        = string
    # default     = "production"
}


variable "project_name" {
    description = "The name of the project"
    type        = string
    # default     = "taskflow"
}

variable "services" {
    description = "List of service names to create repositories for"
    type        = list(string)
    # default     = ["api-gateway", "user-service", "task-service", "notification-service", "frontend"]
}

variable "image_retention_count" {
    description = "Number of images to keep per repository before old ones are deleted"
    type        = number
    # default     = 10
}