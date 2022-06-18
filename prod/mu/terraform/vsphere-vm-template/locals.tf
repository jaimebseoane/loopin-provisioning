// computed variables

locals {
   userdata_template_relative_path = file("${path.module}/${var.userdata_template.relative_path}/${var.userdata_template.filename}")
   userdata_encoded = base64encode(data.template_file.userdata.rendered)

   ip_address = "${var.userdata.subnet_id}.10"
   ipv4_gateway = "${var.userdata.subnet_id}.1"
   dns_suffix_list = ["${var.userdata.subdomain}.${var.userdata.domain}"]

}

