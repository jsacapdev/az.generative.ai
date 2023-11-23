# Generative Open AI

Playground for using advanced language models using [Azure OpenAI Service](https://azure.microsoft.com/en-us/products/ai-services/openai-service).

Creates a series of resources in Azure to support as a playground, including several language [models](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview).

## Deployment

No CI/CD at this stage, but uses infrastructure as code to deploy the resources needed. Using the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/), run the following commands to create a resource group:

`az group create -n rg-genai-dev-001 -l uksouth --tags "productOwner=me@dat.com" "application=Generative AI" "environment=dev" "projectCode=n/a" --debug`

And then deploy the infrastructure as code:

```bash
az deployment group create -f ./main.bicep \
-g rg-genai-dev-001 \
--parameters environment=dev \
location=uksouth \
--debug
```

## Application Code

The code samples are developed in [Python](https://www.python.org/).

[Anaconda](https://www.anaconda.com/) has been used to create the virtual environments.

Once installed, create an environment:

`conda create --name azopenai python=3.11`

And activate it:

`conda activate azopenai`

It can be remove later using the following:

`conda env remove --name azopenai`

Occasionally a GUI for Anaconda is useful (checking packages in a GUI, etc.) and can [installed](https://docs.anaconda.com/free/navigator/install/) and run using the following:

`anaconda-navigator`

When running the python sample, remember to set the interpreter to the environment created above.

Install the dependencies for the sample:

``` bash
conda install openai
pip install tiktoken
```

The credentials to communicate with the chat service can be stored as envioronment varianles using the following commands:

``` bash
export AZURE_OPENAI_KEY="???"
export AZURE_OPENAI_ENDPOINT="https://???.openai.azure.com/"
```

## [Using Own Data](https://learn.microsoft.com/en-us/azure/ai-services/openai/use-your-data-quickstart?tabs=bash%2Cpython&pivots=programming-language-python)

There is an [example](https://github.com/jsacapdev/az.generative.ai/blob/main/src/chat/py/own_data.py) of using natural language against that has been uploaded. To use, set the following envioronment variables:

``` pwsh
$env:AZURE_OPENAI_ENDPOINT="https://openai-genai-dev-001.openai.azure.com/"; 
$env:AZURE_OPENAI_KEY="THE_KEY"; 
$env:AZURE_OPENAI_DEPLOYMENT_ID="gpt-35-turbo"; 
$env:SEARCH_ENDPOINT="https://gptkb-genai-dev-001.search.windows.net/"; 
$env:SEARCH_KEY="THE_KEY"; 
$env:SEARCH_INDEX_NAME="index";
```

A bit of trial and error found that the following packages worked:

```pwsh
pip install openai==0.28.1
pip install python-dotenv
```

And the `gpt-35-turbo` model and `0301` version.

The data itself was [uploaded manually in the portal](https://github.com/Azure-Samples/azure-search-openai-demo/blob/main/scripts/prepdocs.py), and the question in the script [shows](https://github.com/jsacapdev/az.generative.ai/blob/fabf75346cbb354ce5d2bda1802ce459891459fb/src/chat/py/own_data.py#L54C82-L54C82) how we can tailor our ask to our data.
