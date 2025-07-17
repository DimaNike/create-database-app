output "dev_wallet_password" {
  value     = random_password.dev_wallet_password.result
  sensitive = true
}

output "dev_adb_database" {
  value = {
    adb_database_id     = oci_database_autonomous_database.dev_adb_database.id
    connection_urls     = oci_database_autonomous_database.dev_adb_database.connection_urls
  }
}
