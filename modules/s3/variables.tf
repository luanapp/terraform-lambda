variable "buckets" {
  type = list(string)
  description = "List where each item in is the bucket name to create"
}

variable "tags" {
  type        = map(string)
  description = "key-value default mapping for the resource tags"
}