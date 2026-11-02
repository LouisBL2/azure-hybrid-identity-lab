targetScope = 'resourceGroup'

@description('Région Azure')
param location string = resourceGroup().location

@description('Adresse IP publique autorisée pour RDP (à renseigner)')
param adminSourceIp string

resource nsgServers 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: 'nsg-servers'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP-Admin'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: adminSourceIp
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
  tags: {
    projet: 'lab'
  }
}

output nsgId string = nsgServers.id
