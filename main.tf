terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Cloudflare Integration

# Details: https://github.com/indentapis/integrations/tree/6089dac520cb4c8bb0e7ab62cd83dafd4ba6ef6e/packages/beta/indent-integration-cloudflare
# Last Change: https://github.com/indentapis/integrations/commit/6089dac520cb4c8bb0e7ab62cd83dafd4ba6ef6e

module "idt-cloudflare-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-cloudflare-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/cloudflare-6089dac520cb4c8bb0e7ab62cd83dafd4ba6ef6e-function.zip"
    deps_key     = "webhooks/aws/lambda/cloudflare-6089dac520cb4c8bb0e7ab62cd83dafd4ba6ef6e-deps.zip"
  }
  env = {
    CLOUDFLARE_TOKEN   = var.cloudflare_token
    CLOUDFLARE_ACCOUNT = var.cloudflare_account
  }
}

