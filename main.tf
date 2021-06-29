
module "s3" {
  for_each = { for object in toset(var.s3buckets) : object => object }
  source   = "./s3"
  bucket   = each.key
}


module "lambda" {
  for_each = { for object in var.functions : object.name => object }
  source   = "./lambda"

  region    = var.region
  accountid = var.accountid

  name               = each.key
  file               = each.value.file
  role               = module.iam.role
  handler            = each.value.handler
  runtime            = each.value.runtime
  memory_size        = each.value.memory_size
  timeout            = each.value.timeout
  http_method        = each.value.http_method
  request_parameters = each.value.request_parameters
  mapping_template   = each.value.mapping_template
  stage              = each.value.stage

}

module "iam" {
  source = "./iam"
  role   = var.role
}