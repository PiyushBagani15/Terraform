variable "instance-type" {
  type = map
  default = {
    Dev = "t2.micro"
    Prod = "t2.small"
  }
}