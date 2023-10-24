# Generative Open AI

Playground for using advanced language models using [Azure OpenAI Service](https://azure.microsoft.com/en-us/products/ai-services/openai-service).

Creates a series of resources in Azure to support as a playground, including several language [models](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview).

## Deployment

Using the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/), run the following commands to create a resource group:

`az group create -n rg-genai-dev-001 -l uksouth --tags "productOwner=me@dat.com" "application=Generative AI" "environment=dev" "projectCode=n/a" --debug`

And then deploy the infrastructure as code:

```bash
az deployment group create -f ./main.bicep \
-g rg-genai-dev-001 \
--parameters environment=dev \
location=uksouth \
octet=0 \
--debug
```

Start Anaconda.

`anaconda-navigator`

`conda create --name azopenai python=3.7.1`

`conda activate azopenai`

`conda env remove --name azopenai`
