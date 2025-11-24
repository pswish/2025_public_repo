#!/bin/bash

# Simplified Azure deployment for Azure for Students
RESOURCE_GROUP="trivia-simple-rg"
FUNCTION_APP="trivia-functions-$(date +%s)"
STORAGE_ACCOUNT="triviastorage$(date +%s | cut -c6-15)"  # Shorter name

echo "=== Simple Azure Deployment ==="

# Login check
if ! az account show &>/dev/null; then
    echo "❌ Please run: az login"
    exit 1
fi

echo "✓ Using subscription: $(az account show --query name -o tsv)"

# Try Central US (most likely to work)
LOCATION="centralus"

echo "Creating resources in $LOCATION..."

# Create resource group
echo "1. Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create storage account (required for Function App)
echo "2. Creating storage account..."
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS

# Create Function App (consumption plan - free tier)
echo "3. Creating Function App..."
az functionapp create \
  --resource-group $RESOURCE_GROUP \
  --consumption-plan-location $LOCATION \
  --runtime python \
  --runtime-version 3.9 \
  --functions-version 4 \
  --name $FUNCTION_APP \
  --storage-account $STORAGE_ACCOUNT

echo "✓ Basic setup complete!"
echo "Function App URL: https://$FUNCTION_APP.azurewebsites.net"
echo ""
echo "Next steps:"
echo "1. Deploy your Python functions to the Function App"
echo "2. Use local storage or a simple database instead of Cosmos DB"
echo "3. Update your HTML with the Function App URL"