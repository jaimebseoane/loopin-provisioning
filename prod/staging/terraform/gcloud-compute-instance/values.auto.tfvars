// configuration instance input variables

gcp_project   = "tfc-development-261608"
gcp_region    = "europe-west4"
instance_name = "test-compute-instance"
image = "ubuntu-os-cloud/ubuntu-pro-2004-lts"
labels = {
  owner = "tfc"
  environment = "staging"
  app = "tfc"
  ttl = "24"
}
num_of_servers = 1