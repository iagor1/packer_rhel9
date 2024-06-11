/*
    DESCRIPTION:
    Red Hat Enterprise Linux 9 template using the Packer Builder for qemu
    Output generate by qemu builder
*/

variable passwd {
  type    = string
  default = "passwd"
  #change
}

source "qemu" "linux-rhel" {
  iso_url          = "/your_path/rhel-9.4-x86_64-dvd.iso"          #update your path
  iso_checksum     = "sha256:398561d7b66f1a4bf23664f4aa8f2cfbb3641aa2f01a320068e86bd1fc0e9076" #update if needed
  output_directory = "/your_path/packer_rhel9/output"
  shutdown_command = "echo '${var.passwd}' | sudo -S shutdown -P now"
  disk_size        = "10G"
  format           = "qcow2"
  accelerator      = "kvm"
  http_directory   = "http"
  ssh_username     = "test"
  ssh_password     = var.passwd
  ssh_timeout      = "20m"
  vm_name          = "rhel9-kvm.qcow2"
  net_device       = "virtio-net"
  disk_interface   = "virtio"
  boot_wait        = "3s"
  cpus             = "2"
  memory           = "4096"
  qemuargs = [
    [
      "-cpu",
      "host"
    ]
  ]
  boot_command     = [
  "<tab><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg",
  "<enter><wait>"
  ]
  }

build {
  sources = ["source.qemu.linux-rhel"]
}