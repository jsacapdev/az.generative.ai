@minLength(3)
@maxLength(4)
@description('The environment name.')
param environment string = 'dev'

@minLength(1)
@maxLength(20)
@description('The location.')
param location string = 'westeurope'

@description('The subnet octet range.')
param octet int = 0

//////////////////////
// Open AI 
//////////////////////

param openAiSkuName string = 'S0'
param chatGptModelName string = 'gpt-35-turbo'
param chatGptModelVersion string = '0301'
param embeddingModelName string = 'text-embedding-ada-002'
param chatGptDeploymentCapacity int = 30
param embeddingDeploymentCapacity int = 30

//////////////////////
// global variables 
//////////////////////

// product name
var product = 'genai'

param tags object = {
  productOwner: 'me@dat.com'
  application: 'Generative AI'
  environment: 'dev'
  projectCode: 'n/a'
}

// network
var vnetName = 'vnet-${product}-${environment}-001'
var openAiServiceSubnetName = 'snet-${product}-${environment}-001'
var storageSubnetName = 'snet-${product}-${environment}-002'

// open ai
var cognitiveServicesName = 'openai-${product}-${environment}-001'
var searchServiceName = 'gptkb-${product}-${environment}-001'
var storageAccountName = 'st${product}${environment}002'

module network './modules/network.bicep' = {
  name: 'network'
  params: {
    location: location
    vnetName: vnetName
    tags: tags
    openAiServiceSubnetName: openAiServiceSubnetName
    storageSubnetName: storageSubnetName
    octet: octet
  }
}

module storage './modules/storage.bicep' = {
  name: 'storage'
  params: {
    name: storageAccountName
    location: location
    tags: tags
    vnetName: vnetName
    storageSubnetName: storageSubnetName
    allowBlobPublicAccess: false
    publicNetworkAccess: 'Enabled'
    sku: {
      name: 'Standard_LRS'
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 2
    }
    containers: [
      {
        name: 'content'
        publicAccess: 'None'
      }
    ]
  }
}

module cognative './modules/cognative.bicep' = {
  name: 'cognative'
  params: {
    cognitiveServicesName: cognitiveServicesName
    location: location
    tags: tags
    vnetName: vnetName
    openAiServiceSubnetName: openAiServiceSubnetName
    sku: {
      name: openAiSkuName
    }
    deployments: [
      {
        name: chatGptModelName
        model: {
          format: 'OpenAI'
          name: chatGptModelName
          version: chatGptModelVersion
        }
        sku: {
          name: 'Standard'
          capacity: chatGptDeploymentCapacity
        }
      }
      {
        name: embeddingModelName
        model: {
          format: 'OpenAI'
          name: embeddingModelName
          version: '2'
        }
        capacity: embeddingDeploymentCapacity
      }
    ]
  }
}

module searchService './modules/search.bicep' = {
  name: 'search-service'
  params: {
    name: searchServiceName
    location: location
    tags: tags
    authOptions: {
      aadOrApiKey: {
        aadAuthFailureMode: 'http401WithBearerChallenge'
      }
    }
    sku: {
      name: 'standard'
    }
    semanticSearch: 'free'
  }
}
