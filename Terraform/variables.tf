variable "name" {
  description = "the stack"
  default = "plan-a"
}

variable "environment" {
  description = "the environment"
  default     = "prod"
}

variable "region" {
  description = "the AWS region"
  default     = "eu-central-1"
}

variable "aws-region" {
  type        = string
  description = "AWS region to launch servers."
  default     = "eu-central-1"
}

variable "aws-access-key" {
  type = string
}

variable "aws-secret-key" {
  type = string
}


variable "availability_zones" {
  description = "a comma-separated list of availability zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/24"
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets "
  default     = ["10.0.0.0/28", "10.0.0.16/28", "10.0.0.32/28"]
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets "
  default     = ["10.0.0.48/28", "10.0.0.64/28", "10.0.0.80/28"]
}

variable "service_desired_count" {
  description = "Number of tasks running in parallel"
  default     = 2
}

variable "container_port" {
  description = "The port where the Docker is exposed"
  default     = 80
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  default     = 256
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 512
}

variable "health_check_path" {
  description = "Http path for task health check"
  default     = "/"
}

variable "container_image" {
  description = "Docker image to be launched"
  default = "nginx"
}

variable "repo_name" {
  description = "Codepipeline repo"
  default = "ecs-fargate-cluster"
}

variable "deployment_config_name" {
  default = "CodeDeployDefault.ECSAllAtOnce"  
}

variable "termination_wait_time_in_minutes" {
  default = 30
}