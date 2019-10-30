data "aws_ami" "amazon_linux_2" {
  # Finding Amazon Linux 2 AMI: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
  # aws ec2 describe-images --owners amazon --filters 'Name=name,Values=amzn2-ami-hvm-2.0.????????-x86_64-gp2' 'Name=state,Values=available' --query 'reverse(sort_by(Images, &CreationDate))[:1].ImageId' --output text
  owners      = ["amazon"]
  most_recent = true

  filter {
      name   = "name"
      values = ["amzn2-ami-hvm-2.0*"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "enis" {
  type = list(object({
      attr1 = string
      attr2 = string
  }))
  
  default = [
    {
      attr1="123", 
      attr2="456"
    }, 
    {
      attr1="abc",
      attr2="def"
    }
  ]
}

variable "filters" {
  type = list(object({
      name = string
      values = list(string)
  }))

  default = [
    {
      name = "name"
      values = ["amzn2-ami-hvm-2.0*"]
    },
    {
      name = "architecture"
      values = ["x86_64"]
    }
  ]
}

data "aws_ami" "this" {
  owners      = ["amazon"]
  most_recent = true

  # https://www.terraform.io/docs/configuration/attr-as-blocks.html
  # filter [
  #   for f in var.filters: {
  #     name = f.name
  #     values = f.values
  #   }
  # ]

  # https://www.terraform.io/docs/configuration/expressions.html#dynamic-blocks
  dynamic "filter" {
    for_each = var.filters
    content {
      name = filter.value.name
      values   = filter.value.values
    }
  }
}

output "ami_id_amazon_linux_2" {
  value = data.aws_ami.amazon_linux_2
}

output "ami_id_dynamic_block" {
  value = data.aws_ami.this
}

output "timestamp" {
  value = "final-snapshot-${substr(timestamp(),0,10)}"
}