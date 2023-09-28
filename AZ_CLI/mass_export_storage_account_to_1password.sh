#!/bin/bash
# SCRIPT FOR EXPORTING AZURE STORAGE ACCOUNT KEYs TO 1password directly

# Define the storage account names
storage_accounts=("account1" "account2")

# Loop over the storage accounts
for storage_account in "${storage_accounts[@]}"
do
  # Debug message
  echo "Processing: $storage_account"
  
  # Export the connection string
  connection_string=$(az storage account show-connection-string --name "$storage_account" --resource-group iqhosting_statick --subscription AZURE-SUBSCRIPTION-NAME --query connectionString --output tsv)

  # If the Azure command succeeds
  if [ $? -eq 0 ]; then
    # Create an item in 1Password using the correct command format
    op item create --category="API Credential" --title="$storage_account" --vault=vault-ID --tags=AZURE,STORAGE "Connection String=$connection_string"
  else
    echo "Error retrieving connection string for $storage_account"
  fi
done
