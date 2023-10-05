terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Cloudflare Integration

# Details: https://github.com/indentapis/integrations/tree/a92c460436809126aa494a6e033394196aacea44/packages/beta/indent-integration-cloudflare
# Last Change: https://github.com/indentapis/integrations/commit/a92c460436809126aa494a6e033394196aacea44

module "idt-cloudflare-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-cloudflare-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/cloudflare-a92c460436809126aa494a6e033394196aacea44-function.zip"
    deps_key     = "webhooks/aws/lambda/cloudflare-a92c460436809126aa494a6e033394196aacea44-deps.zip"
  }
  env = {
    CLOUDFLARE_TOKEN   = var.cloudflare_token
    CLOUDFLARE_ACCOUNT = var.cloudflare_account
  }
}

