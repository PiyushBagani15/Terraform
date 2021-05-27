#(required) variable cidr
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

#variable for Availability zones
variable "subnets_cidr" {
    type = list
    default = [ "10.0.1.0/24" , "10.0.2.0/24"]
}

#variable for Availability zones
variable "azs" {
    default = [ "ap-south-1a" , "ap-south-1b"]
}

