Login-AzureRmAccount

Select-AzureRmSubscription -SubscriptionId d785053c-01de-4390-9760-fa22e2126078


$policy = New-AzureRmPolicyDefinition -Name ensureStoreEncrypt -Description "Policy to prevent storage being created without encryption enabled" -Policy '{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Storage/storageAccounts"
      },
      {
        "not": {
          "allof": [
            {
              "field": "Microsoft.Storage/storageAccounts/enableBlobEncryption",
              "in": ["true"]
            }
          ]
        }
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}'  
       

# Create ARM Policy and assign using the above Policy definition defined 
New-AzureRmPolicyAssignment -Name ensureStoreEncrypt -PolicyDefinition $policy -Scope /subscriptions/d785053c-01de-4390-9760-fa22e2126078 # /resourceGroups/<resource-group-name>

# Remove ARM Policy

Remove-AzureRmPolicyAssignment -Name ensureStoreEncrypt -PolicyDefinition $policy -Scope /subscriptions/d785053c-01de-4390-9760-fa22e2126078