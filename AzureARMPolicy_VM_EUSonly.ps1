$policy = New-AzureRmPolicyDefinition -Name ApprovedUSLocationsforIaaS -Description "Policy to allow VM resource creation in East US" -Policy '{
    "if": {
        "allOf": [
          {
            "not": {
              "field": "location",
              "contains": "eastus"
            }
          },
          {
            "field": "type",
            "equals": "Microsoft.Compute/virtualMachines"
          }
        ]
    },
    "then": {
        "effect": "Deny"
    }
}'


New-AzureRmPolicyAssignment -Name ApprovedUSLocationsforIaaS -PolicyDefinition $policy -Scope /subscriptions/subid

