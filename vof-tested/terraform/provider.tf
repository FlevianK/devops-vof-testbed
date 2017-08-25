
provider "google" {
  "credentials" = "${file("/Users/fleviankanaiza/DevOps/vof-tested/Testbed.json")}"
  "project"     = "vof-testbed-2"
  "region"      = "${var.region}"
}
