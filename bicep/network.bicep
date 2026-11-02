targetScope = 'resourceGroup'

@description('Région Azure')
param location string = resourceGroup().location

@description('Nom du réseau virtuel')
param vnetName string = 'vnet-lab'

@description('Identifiant du NSG à rattacher au sous-réseau')
param nsgId string

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
    }
  subnets: [
    {
      name: 'snet-servers'
      properties: {
        addressPrefix: '10.10.1.0/24'
        networkSecurityGroup: {
          id: nsgId
        }
      }
    }
  ]
  }
  tags: {
    projet: 'lab'
  }
}
