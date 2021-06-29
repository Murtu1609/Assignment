
output "urls" {
value = [for func in var.functions : module.lambda[func.name].url]
}