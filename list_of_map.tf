variable "list_of_maps" {
  type        = list(map(string))
  default     = [
  ]
}

variable "list_of_maps2" {
  type        = list(map(string))
  default     = [
    {
      name = "list_of_maps2"
    }
  ]
}

variable "list_of_maps3" {
  type        = list(map(string))
  default     = [
    {
      name = "list_of_maps3"
    }
  ]
}

locals {
  list_of_maps = concat(var.list_of_maps, var.list_of_maps2, var.list_of_maps3)
}

output "list_of_maps" {
  value = local.list_of_maps
}