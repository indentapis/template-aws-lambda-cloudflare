terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Cloudflare Integration

# Details: https://github.com/indentapis/integrations/tree/dbd8daa41dbfdf0d2b2f5fae9ff74cd858452f55/packages/beta/indent-integration-cloudflare
# Last Change: https://github.com/indentapis/integrations/commit/dbd8daa41dbfdf0d2b2f5fae9ff74cd858452f55

module "idt-cloudflare-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-cloudflare-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/cloudflare-dbd8daa41dbfdf0d2b2f5fae9ff74cd858452f55-function.zip"
    deps_key     = "webhooks/aws/lambda/cloudflare-dbd8daa41dbfdf0d2b2f5fae9ff74cd858452f55-deps.zip"
  }
  env = {
    CLOUDFLARE_TOKEN   = var.cloudflare_token
    CLOUDFLARE_ACCOUNT = var.cloudflare_account
  }
}

