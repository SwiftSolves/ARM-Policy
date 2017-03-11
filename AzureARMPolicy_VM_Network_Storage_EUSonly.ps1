$policy = New-AzureRmPolicyDefinition -Name ApprovedUSLocationsforIaaS -Description "Policy to allow VM, Network,Storage resource creation in East US" -Policy '{
    "if": {
        "allOf": [
          {
            "not": {
              "field": "location",
              "contains": "eastus"
            }
          },
          {
          "anyof": [
          {
            "field": "type",
            "equals": "Microsoft.Compute/virtualMachines"
          },
          {
            "field": "type",
            "equals": "Microsoft.Network/virtualNetworks"
          },
          {
            "field": "type",
            "equals": "Microsoft.Storage/storageAccounts"
          }
          ]
          }
        ]
    },
    "then": {
        "effect": "Deny"
    }
}'


New-AzureRmPolicyAssignment -Name ApprovedUSLocationsforIaaS -PolicyDefinition $policy -Scope /subscriptions/subid

