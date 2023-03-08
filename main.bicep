@secure()
param administratorLoginPassword string
param administratorLogin string = 'postgres'
param location string = resourceGroup().location
param serverName string 
param serverEdition string = 'GeneralPurpose'
param skuSizeGB int = 128
param dbInstanceType string = 'Standard_D4ds_v4'
param haMode string = 'ZoneRedundant'
param availabilityZone string = '1'
param version string = '14'
//param virtualNetworkExternalId string = ''
//param subnetName string = ''
//param privateDnsZoneArmResourceId string = ''
param startipaddress string = '0.0.0.0'
param endipaddress string = '255.255.255.255'

resource newflexibleserver 'Microsoft.DBforPostgreSQL/flexibleServers@2021-06-01' = {
  name: serverName
  location: location
  sku: {
    name: dbInstanceType
    tier: serverEdition
  }
  properties: {
    version: version
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    network: {
      //delegatedSubnetResourceId: (empty(virtualNetworkExternalId) ? json('null') : json('\'${virtualNetworkExternalId}/subnets/${subnetName}\''))
      //privateDnsZoneArmResourceId: (empty(virtualNetworkExternalId) ? json('null') : privateDnsZoneArmResourceId)
    }
    highAvailability: {
      mode: haMode
    }
    storage: {
      storageSizeGB: skuSizeGB
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    availabilityZone: availabilityZone
  }
}
resource newfirewallrule 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2022-12-01' = {  
    name: 'InitialRule'
  parent: newflexibleserver
  properties: {
    endIpAddress: endipaddress
    startIpAddress: startipaddress
  }
}
