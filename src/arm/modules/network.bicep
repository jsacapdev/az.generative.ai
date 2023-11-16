@description('Name')
param vnetName string

@description('Name')
param openAiServiceSubnetName string

@description('Name')
param storageSubnetName string

@description('The location.')
param location string

@description('Tags')
param tags object

@description('.')
param octet int

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  tags: tags
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.${octet}.0/19'
      ]
    }
    subnets: [
      {
        name: openAiServiceSubnetName
        properties: {
          addressPrefix: '10.2.${octet}.0/24'
          serviceEndpoints: [
            {
              service: 'Microsoft.CognitiveServices'
            }
          ]
        }
      }
      {
        name: storageSubnetName
        properties: {
          addressPrefix: '10.2.${octet + 1}.0/24'
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
    ]
  }
}
