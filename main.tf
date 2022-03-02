resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    contract_input = jsonencode({
        "type" = "object",
        "additionalProperties" = true,
        "properties" = {
            "body" = {
                "type" = "string"
            },
            "from" = {
                "type" = "string"
            },
            "to" = {
                "type" = "string"
            }
        },
    })

    contract_output = jsonencode({
        "type" = "object",
        "additionalProperties" = true,
        "properties" = {
            "conversationId" = {
                "type" = "string"
            }
        },
    })
    
    config_request {
        request_template     = "{\n  \"fromAddress\": \"$${input.from}\",\n  \"toAddress\": \"$${input.to}\",\n  \"toAddressMessengerType\": \"sms\",\n  \"textBody\": \"$${input.body}\"\n}"
        request_type         = "POST"
        request_url_template = "/api/v2/conversations/messages/agentless"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}