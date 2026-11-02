targetScope = 'resourceGroup'

@description('Région Azure')
param location string = resourceGroup().location

@description('IP publique autorisée pour RDP (renseignée au déploiement)')
param adminSourceIp string

module nsg 'nsg.bicep' = {
  name: 'deployNsg'
  params: {
    location: location
    adminSourceIp: adminSourceIp
  }
}

module network 'network.bicep' = {
  name: 'deployNetwork'
  params: {
    location: location
    nsgId: nsg.outputs.nsgId
  }
}
