# Generative Open AI

Generative Open AI on Azure. Boom.

Deploy.

`az group create -n rg-genai-dev-001 -l uksouth --tags "productOwner=jas.atwal@capgemini.com" "application=Generative AI" "environment=dev" "projectCode=n/a" --debug`

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
