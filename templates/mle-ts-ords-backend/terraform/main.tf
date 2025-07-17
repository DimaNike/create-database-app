provider "oci" {
  # Automatically uses ~/.oci/config with [DEFAULT] profile
  config_file_profile = "DEFAULT"
}

resource "random_password" "dev_adb_admin_password" {
  length           = 16
  special          = false
  min_numeric      = 2
  override_special = ""
}

resource "random_password" "app_user_stage_password" {
  length           = 16
  special          = false
  min_numeric      = 2
  override_special = ""
}

resource "oci_database_autonomous_database" "dev_adb_database" {
  admin_password           = random_password.dev_adb_admin_password.result
  compartment_id           = var.dev_compartment_ocid

  db_name                  = var.dev_adb_database_db_name
  db_workload              = var.dev_adb_database_db_workload
  display_name             = var.dev_adb_database_display_name
  
  data_storage_size_in_gb  = "20"
  cpu_core_count           = "1"
  is_free_tier             = "true"
  db_version               = "23ai"
  license_model            = "LICENSE_INCLUDED"
  is_mtls_connection_required = "true"
  autonomous_maintenance_schedule_type = "REGULAR"
  is_preview_version_with_service_terms_accepted = "false"
}

resource "random_password" "dev_wallet_password" {
  length           = var.dev_adb_wallet_password_length
  special          = false
  min_numeric      = var.dev_adb_wallet_password_min_numeric
  override_special = var.dev_adb_wallet_password_override_special
}

resource "local_file" "stage_env_secrets" {
  content  = <<EOF
MLE_APP_WALLET_STAGE_PASS="${random_password.dev_wallet_password.result}"
MLECLI_WALLET_PASS="${random_password.dev_wallet_password.result}"
MLECLI_PASSWORD="${random_password.app_user_stage_password.result}"
MLE_APP_USER_STAGE_PASS="${random_password.app_user_stage_password.result}"
MLE_APP_ADMIN_STAGE_PASS="${random_password.dev_adb_admin_password.result}"
MLE_APP_ORDS_URL="${oci_database_autonomous_database.dev_adb_database.connection_urls[0].ords_url}"
MLE_APP_DB_NAME_STAGE="${oci_database_autonomous_database.dev_adb_database.connection_strings[0].profiles[0].display_name}"
EOF
  filename = abspath("${path.module}/../.env.stage.auto")
  file_permission = "0600"
}

resource "oci_database_autonomous_database_wallet" "dev_adb_database_wallet" {
  autonomous_database_id = oci_database_autonomous_database.dev_adb_database.id
  password               = random_password.dev_wallet_password.result
  base64_encode_content  = "true"
}

resource "local_file" "wallet_zip" {
  content_base64 = oci_database_autonomous_database_wallet.dev_adb_database_wallet.content
  filename       = "${path.module}/wallet/wallet.zip"
  file_permission = "0600"
}

resource "null_resource" "extract_wallet" {
  depends_on = [local_file.wallet_zip]

  provisioner "local-exec" {
    command = <<EOT
mkdir -p ${path.module}/wallet/unzipped
unzip -o ${path.module}/wallet/wallet.zip -d ${path.module}/wallet/unzipped
chmod -R 600 ${path.module}/wallet/unzipped
chmod 700 ${path.module}/wallet/unzipped
EOT
  }

  triggers = {
    hash = sha256(local_file.wallet_zip.content_base64)
  }
}

resource "null_resource" "run_bootstrap_stage" {
  depends_on = [
    oci_database_autonomous_database.dev_adb_database,
    null_resource.extract_wallet
  ]

  provisioner "local-exec" {
    command = "bash -c '../database/bootstrap-stage.sh'"
  }
}

resource "local_file" "mleclirc" {
  filename = abspath("${path.module}/../mleclistage.json")
  content  = jsonencode({
    walletLocation        = abspath("${path.module}/wallet/unzipped")
    connString = oci_database_autonomous_database.dev_adb_database.connection_strings[0].profiles[0].display_name
  })
  file_permission = "0600"
}
