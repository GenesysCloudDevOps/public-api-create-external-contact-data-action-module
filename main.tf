resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "cellPhone" = {
                "type" = "string"
            },
            "firstName" = {
                "type" = "string"
            },
            "homePhone" = {
                "type" = "string"
            },
            "lastName" = {
                "type" = "string"
            },
            "middleName" = {
                "type" = "string"
            },
            "otherEmail" = {
                "type" = "string"
            },
            "otherPhone" = {
                "type" = "string"
            },
            "personalEmail" = {
                "type" = "string"
            },
            "workEmail" = {
                "type" = "string"
            },
            "workPhone" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "externalContactId" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    
    config_request {
        request_template     = "{\n\"firstName\": \"$!{input.firstName}\",\n\"middleName\": \"$!{input.middleName}\",\n\"lastName\": \"$!{input.lastName}\",\n\"workPhone\": {\n\"display\": \"$!{input.workPhone}\"\n},\n\"cellPhone\": {\n\"display\": \"$!{input.cellPhone}\"\n},\n\"homePhone\": {\n\"display\": \"$!{input.homePhone}\"\n},\n\"otherPhone\": {\n\"display\": \"$!{input.otherPhone}\"\n},\n\"workEmail\": \"$!{input.workEmail}\",\n\"personalEmail\": \"$!{input.personalEmail}\",\n\"otherEmail\": \"$!{input.otherEmail}\"\n}"
        request_type         = "POST"
        request_url_template = "/api/v2/externalcontacts/contacts"
    }

    config_response {
        success_template = "{ \"externalContactId\": $${externalContactId} }"
        translation_map = { 
            externalContactId = "$.id"
        }
        translation_map_defaults = {       
            externalContactId = "\"\""
        }
    }
}