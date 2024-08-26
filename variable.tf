variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "VPC CIDR Block"
  type = string
}

variable "public-subnet-az1-cidr" {
  default = "10.0.0.0/24"
  description = "Pulic subnet az1 CIDR Block"
  type = string
}

variable "public-subnet-az2-cidr" {
  default = "10.0.1.0/24"
  description = "Pulic subnet az2 CIDR Block"
  type = string
}

variable "private-app-subnet-az1-cidr" {
  default = "10.0.2.0/24"
  description = "Private app subnet az1 CIDR Block"
  type = string
}

variable "private-app-subnet-az2-cidr" {
  default = "10.0.3.0/24"
  description = "Private app subnet az2 CIDR Block"
  type = string
}

variable "private-data-subnet-az1-cidr" {
  default = "10.0.4.0/24"
  description = "Private data subnet az1 CIDR Block"
  type = string
}

variable "private-data-subnet-az2-cidr" {
  default = "10.0.5.0/24"
  description = "Private data subnet az2 CIDR Block"
  type = string
}