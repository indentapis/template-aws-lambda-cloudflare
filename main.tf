terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Cloudflare Integration

# Details: https://github.com/indentapis/integrations/tree/17108bd50ac2085c099c40b348776fc655915b48/packages/beta/indent-integration-cloudflare
# Last Change: https://github.com/indentapis/integrations/commit/17108bd50ac2085c099c40b348776fc655915b48

module "idt-cloudflare-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-cloudflare-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/cloudflare-17108bd50ac2085c099c40b348776fc655915b48-function.zip"
    deps_key     = "webhooks/aws/lambda/cloudflare-17108bd50ac2085c099c40b348776fc655915b48-deps.zip"
  }
  env = {
    CLOUDFLARE_TOKEN   = var.cloudflare_token
    CLOUDFLARE_ACCOUNT = var.cloudflare_account
  }
}

