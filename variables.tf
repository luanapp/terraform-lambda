variable "env" {
  default = "prod"
}

variable "prefix" {
  default = "luana-pimentel"
}

variable "tags" {
  type        = map(string)
  description = "key-value default mapping of the resource tags"
  default = {
    "application"       = "example-application"
    "env"               = "prod"
  }
}