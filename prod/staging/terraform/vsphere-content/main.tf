data "vsphere_datacenter" "dc" {
  name = var.vs_configuration.datacenter
}

data "vsphere_content_library" "content_library" {
  name = "ContentLibrary"
}

resource "vsphere_content_library_item" "content_library_item" {
  name        = var.content_upload.name
  description = var.content_upload.description
  type        = var.content_upload.type
  file_url    = var.content_upload.file_url
  library_id  = data.vsphere_content_library.content_library.id
}