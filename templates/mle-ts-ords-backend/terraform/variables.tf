## Copyright (c) 2021 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "dev_compartment_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaazqrqv3xphisrlu7n3impgdtl625qusuihxf7ja7ryh577tmacggq"
}


variable "dev_adb_database_db_name" {
  default = "DEVADB"
}

variable "dev_adb_admin_password" {
  default = "oracle"
}

variable "dev_adb_database_db_version" {
  default = "23ai"
}

variable "dev_adb_database_db_workload" {
  default = "OLTP"
}

variable "dev_adb_database_display_name" {
  default = "DEVADB"
}

variable "adb_tde_wallet_zip_file" {
  default = "tde_wallet_adb1.zip"
}

variable "dev_adb_wallet_password_specials" {
  default = true
}

variable "dev_adb_wallet_password_length" {
  default = 16
}

variable "dev_adb_wallet_password_min_numeric" {
  default = 2
}

variable "dev_adb_wallet_password_override_special" {
  default = ""
}
