# --- root/locals.tf ---

locals {
  kis_os_auth_url = "https://158.193.152.44:5000/v3/"

  kis_os_region   = "RegionOne"
  

  kis_os_endpoint_overrides = {
    network = "https://158.193.152.44:9696/v2.0/"
    image = "https://158.193.152.44:9292/v2.0/"
    compute = "https://158.193.152.44:8774/v2.1/"
  }

  domain_name="admin_domain"

  project= lower("${var.tenant_name}-minikube")

  my_public_ip = "${data.http.my_public_ip.response_body}/32"
}