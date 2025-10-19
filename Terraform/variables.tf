variable "region" {
  default = "us-east-1"
}

variable "zone" {
  default = "us-east-1a"
}

variable "amiID" {
  type    = string
  default = "ami-0360c520857e3138f"
}

variable "instance_type" {
  type    = string
  default = "c7i-flex.large"
}
