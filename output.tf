output "idt-cloudflare-webhook-url" {
  value       = module.idt-cloudflare-webhook.function_url
  description = "The URL of the deployed Lambda"
}

