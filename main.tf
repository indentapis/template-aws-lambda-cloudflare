terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Cloudflare Integration

# Details: https://github.com/indentapis/integrations/tree/870b4b4de0a6a184eca8998e3d671f5f1c99db69/packages/beta/indent-integration-cloudflare
# Last Change: https://github.com/indentapis/integrations/commit/870b4b4de0a6a184eca8998e3d671f5f1c99db69

module "idt-cloudflare-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-cloudflare-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/cloudflare-870b4b4de0a6a184eca8998e3d671f5f1c99db69-function.zip"
    deps_key     = "webhooks/aws/lambda/cloudflare-870b4b4de0a6a184eca8998e3d671f5f1c99db69-deps.zip"
  }
  env = {
    CLOUDFLARE_TOKEN   = var.cloudflare_token
    CLOUDFLARE_ACCOUNT = var.cloudflare_account
  }
}

