param location string
param loadTestName string
param bacIdentityName string
param froIdentityName string

resource loadtests_resource 'Microsoft.LoadTestService/loadtests@2024-12-01-preview' = {
  name: loadTestName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}

resource bacIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  name: bacIdentityName
  location: location
}

resource froIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  name: froIdentityName
  location: location
}

resource bacFederatedCredential 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2025-01-31-preview' = {
  parent: bacIdentity
  name: 'kpd6ox2y5rkrg'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:EliotLouys/az-fileshare-backend:ref:refs/heads/main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}

resource froFederatedCredential 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2025-01-31-preview' = {
  parent: froIdentity
  name: 'kpd6ox2y5rkrg'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:EliotLouys/az-fileshare-frontend:ref:refs/heads/main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}
