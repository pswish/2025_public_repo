#!/bin/bash

# Azure deployment script with better error handling
RESOURCE_GROUP="trivia-game-rg"
FUNCTION_APP="trivia-game-functions"
STORAGE_ACCOUNT="triviagamestorage$(date +%s)"  # Add timestamp to make unique
COSMOS_ACCOUNT="trivia-cosmos-db$(date +%s)"   # Add timestamp to make unique
# Try multiple regions for Azure for Students
ALLOWED_REGIONS=("centralus" "westus2" "westeurope" "southeastasia")
LOCATION=""  # Will be set after testing

echo "=== Azure Deployment Diagnostics ==="

# Check login status
echo "Checking login status..."
if ! az account show &>/dev/null; then
    echo "❌ Not logged in to Azure. Run: az login"
    exit 1
fi

# Show current subscription
echo "✓ Logged in successfully"
echo "Current subscription: $(az account show --query name -o tsv)"
echo "Subscription ID: $(az account show --query id -o tsv)"

# Check if resource group already exists
echo "\nChecking if resource group exists..."
if az group show --name $RESOURCE_GROUP &>/dev/null; then
    echo "⚠️  Resource group $RESOURCE_GROUP already exists"
else
    echo "✓ Resource group name available"
fi

echo "\n=== Starting Deployment ==="

# Find an allowed region
echo "Testing allowed regions for Azure for Students..."
for region in "${ALLOWED_REGIONS[@]}"; do
    echo "Testing region: $region"
    if az group create --name "test-rg-$region" --location "$region" &>/dev/null; then
        echo "✓ Region $region is allowed"
        LOCATION="$region"
        # Clean up test resource group
        az group delete --name "test-rg-$region" --yes --no-wait &>/dev/null
        break
    else
        echo "❌ Region $region is not allowed"
    fi
done

if [ -z "$LOCATION" ]; then
    echo "❌ No allowed regions found. Check your Azure for Students restrictions."
    exit 1
fi

echo "Using region: $LOCATION"

# Create resource group
echo "Creating resource group: $RESOURCE_GROUP in $LOCATION"
if az group create --name $RESOURCE_GROUP --location $LOCATION; then
    echo "✓ Resource group created successfully"
else
    echo "❌ Failed to create resource group"
    exit 1
fi

# Refresh subscription (fix for Azure for Students)
echo "Refreshing subscription..."
az account set --subscription "Azure for Students"

# Create storage account
echo "Creating storage account: $STORAGE_ACCOUNT"
if az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS \
  --subscription "Azure for Students"; then
    echo "✓ Storage account created successfully"
else
    echo "❌ Failed to create storage account"
    exit 1
fi

# Create Cosmos DB account
echo "Creating Cosmos DB account: $COSMOS_ACCOUNT"
az cosmosdb create \
  --name $COSMOS_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --locations regionName="East US" \
  --subscription "Azure for Students"

# Create Cosmos DB database and container
az cosmosdb sql database create \
  --account-name $COSMOS_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --name "TriviaGame"

az cosmosdb sql container create \
  --account-name $COSMOS_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --database-name "TriviaGame" \
  --name "GameSessions" \
  --partition-key-path "/session_id"

# Create Function App
echo "Creating Function App: $FUNCTION_APP"
az functionapp create \
  --resource-group $RESOURCE_GROUP \
  --consumption-plan-location "East US" \
  --runtime python \
  --runtime-version 3.9 \
  --functions-version 4 \
  --name $FUNCTION_APP \
  --storage-account $STORAGE_ACCOUNT \
  --subscription "Azure for Students"

# Create blob container
az storage container create \
  --name "trivia-questions" \
  --account-name $STORAGE_ACCOUNT

# Upload questions.json to blob storage
az storage blob upload \
  --account-name $STORAGE_ACCOUNT \
  --container-name "trivia-questions" \
  --name "questions.json" \
  --file "questions.json"

echo "✓ Azure resources created successfully"
echo "Update your HTML file with the new Function App URLs"