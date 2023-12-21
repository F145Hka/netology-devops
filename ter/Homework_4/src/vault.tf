provider "vault" {
 address = "http://127.0.0.1:8200"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

resource "vault_generic_secret" "put_generic" {
  path = "secret/put_generic"
  data_json = jsonencode(
    {
      user     = "user",
      password = "mystrongpassword"
    }
  )
}

resource "vault_mount" "kv-v2" {
  path = "kv-v2-test"
  type = "kv-v2"
}

resource "vault_kv_secret_v2" "test_credentials" {
  mount               = vault_mount.kv-v2.path
  name                = "credentials"
  delete_all_versions = true
  data_json = jsonencode(
    {
      user     = "user",
      password = "mystrongpassword"
    }
  )
}