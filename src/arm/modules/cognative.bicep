@description('Name')
param cognitiveServicesName string

@description('Name')
param cognitiveServicesKind string = 'OpenAI'

@description('The location.')
param location string

@description('Tags')
param tags object

@description('Name')
param vnetName string

@description('Name')
param openAiServiceSubnetName string

@description('The location.')
param publicNetworkAccess string = 'Enabled'

param sku object

param deployments array = []

resource account 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: cognitiveServicesName
  location: location
  tags: tags
  kind: cognitiveServicesKind
  properties: {
    customSubDomainName: toLower(cognitiveServicesName)
    publicNetworkAccess: publicNetworkAccess
    networkAcls: {
      defaultAction: 'Allow'
      ipRules: [
        {
          value: '20.68.23.237'
        }
      ]
      virtualNetworkRules: [
        {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, openAiServiceSubnetName)
        }
      ]
    }
  }
  sku: sku
}

@batchSize(1)
resource deployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = [for deployment in deployments: {
  parent: account
  name: deployment.name
  properties: {
    model: deployment.model
    raiPolicyName: contains(deployment, 'raiPolicyName') ? deployment.raiPolicyName : null
  }
  sku: contains(deployment, 'sku') ? deployment.sku : {
    name: 'Standard'
    capacity: 20
  }
}]

output endpoint string = account.properties.endpoint
output id string = account.id
output name string = account.name
