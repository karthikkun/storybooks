output "instance_public_url" {
  value = "${aws_instance.web.public_ip}"
  description = "The public URL of the instance."
}