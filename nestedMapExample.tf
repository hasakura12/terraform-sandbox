variable "nested_map_name" {
  default = {
    default = {
      value1 = 10
      value2 = false

      a = {
        a1 = "a1"
        a2 = "a2"
      }
    }

    staging = {
      value1 = 20
      value2 = false
    }

    production = {
      value1 = 50
      value2 = true
    }
  }
}

# https://github.com/hashicorp/terraform/issues/11036
# output "resource_name" {
#   value = "${lookup(var.nested_map_name[terraform.workspace], "a")}"
# }

