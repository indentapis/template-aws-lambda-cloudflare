terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Cloudflare Integration

# Details: https://github.com/indentapis/integrations/tree/c31c0a2f5371078d198ff8ae1a847404c628620e/packages/beta/indent-integration-cloudflare
# Last Change: https://github.com/indentapis/integrations/commit/c31c0a2f5371078d198ff8ae1a847404c628620e

module "idt-cloudflare-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-cloudflare-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/cloudflare-c31c0a2f5371078d198ff8ae1a847404c628620e-function.zip"
    deps_key     = "webhooks/aws/lambda/cloudflare-c31c0a2f5371078d198ff8ae1a847404c628620e-deps.zip"
  }
  env = {
    CLOUDFLARE_TOKEN   = var.cloudflare_token
    CLOUDFLARE_ACCOUNT = var.cloudflare_account
  }
}

