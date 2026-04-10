param location string
param vnetName string
param publicIpName string

output publicIpId string = publicIP.id
output subnet1Id string = subnet1.id
output subnet2Id string = subnet2.id
output vnetId string = vnet.id

resource publicIP 'Microsoft.Network/publicIPAddresses@2025-05-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    ipAddress: '20.250.72.132'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    // Subnets are declared as child resources below; the ARM export embeds them
    // inline here but that pattern creates circular refs in Bicep. Azure will
    // populate this list automatically once the subnet resources are deployed.
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

// Subnet2 has no delegations, declared first so subnet1 dependsOn ordering is clear
resource subnet2 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${vnetName}-subnet2'
  parent: vnet
  properties: {
    addressPrefixes: [
      '10.0.1.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
}

// Subnet1 is the App Gateway subnet
resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${vnetName}-subnet1'
  parent: vnet
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    subnet2
  ]
}
