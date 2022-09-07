export RESOURCE_GROUP=learn-7788b981-5143-4c19-9329-b7369b5f102c
export AZURE_REGION=centralus
export AZURE_APP_PLAN=popupappplan-$RANDOM
export AZURE_WEB_APP=popupwebapp-$RANDOM


az group list --output table

az group list --query "[?name == '$RESOURCE_GROUP']"



az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
az appservice plan list --output table


az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN

az webapp list --output table


az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/dlqbq/dlqbq.git" --branch gh-pages --manual-integration




$RANDOM=Get-Random
$RESOURCE_GROUP="learn-7788b981-5143-4c19-9329-b7369b5f102c"
$AZURE_REGION="centralus"
$AZURE_APP_PLAN="popupappplan-$RANDOM"
$AZURE_WEB_APP="popupwebapp-$RANDOM"

az group create --name $RESOURCE_GROUP --location $AZURE_REGION

az webapp up --location $AZURE_REGION --name test --html
