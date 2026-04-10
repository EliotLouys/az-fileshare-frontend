param location string
param appGatewayName string
param publicIpId string
param wafPolicyId string

resource appGateway 'Microsoft.Network/applicationGateways@2025-05-01' = {
  name: appGatewayName
  location: location
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
      family: 'Generation_1'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        id: '${appGateway.id}/gatewayIPConfigurations/appGatewayIpConfig'
        properties: {
          subnet: {
            id: virtualNetworks_az_fileshare_virtual_network_name_virtualNetworks_az_fileshare_virtual_network_name_subnet1.id
          }
        }
      }
    ]
    sslCertificates: []
    trustedRootCertificates: []
    trustedClientCertificates: []
    sslProfiles: []
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIpIPv4'
        id: '${appGateway.id}/frontendIPConfigurations/appGwPublicFrontendIpIPv4'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIpId
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        id: '${appGateway.id}/frontendPorts/port_80'
        properties: {
          port: 80
        }
      }
      {
        name: 'port_81'
        id: '${appGateway.id}/frontendPorts/port_81'
        properties: {
          port: 81
        }
      }
    ]
    backendAddressPools: [
      {
        name: '${appGatewayName}-backend-pool'
        id: '${appGateway.id}/backendAddressPools/${appGatewayName}-backend-pool'
        properties: {
          backendAddresses: [
            {
              fqdn: 'az-fileshare-backend-hug6ake3a8amdyc7.switzerlandnorth-01.azurewebsites.net'
            }
          ]
        }
      }
      {
        name: '${appGatewayName}-frontend-pool'
        id: '${appGateway.id}/backendAddressPools/${appGatewayName}-frontend-pool'
        properties: {
          backendAddresses: [
            {
              fqdn: 'az-fileshare-frontend-a7ahe4atbja4dsdu.switzerlandnorth-01.azurewebsites.net'
            }
          ]
        }
      }
    ]
    loadDistributionPolicies: []
    backendHttpSettingsCollection: [
      {
        name: '${appGatewayName}-backend-setting'
        id: '${appGateway.id}/backendHttpSettingsCollection/${appGatewayName}-backend-setting'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: true
          dedicatedBackendConnection: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          validateCertChainAndExpiry: true
          validateSNI: true
          requestTimeout: 20
          probe: {
            id: '${appGateway.id}/probes/healthSec'
          }
        }
      }
      {
        name: '${appGatewayName}-frontend-setting'
        id: '${appGateway.id}/backendHttpSettingsCollection/${appGatewayName}-frontend-setting'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: true
          dedicatedBackendConnection: false
          validateCertChainAndExpiry: true
          validateSNI: true
          requestTimeout: 20
        }
      }
    ]
    backendSettingsCollection: []
    httpListeners: [
      {
        name: '${appGatewayName}-listener1'
        id: '${appGateway.id}/httpListeners/${appGatewayName}-listener1'
        properties: {
          frontendIPConfiguration: {
            id: '${appGateway.id}/frontendIPConfigurations/appGwPublicFrontendIpIPv4'
          }
          frontendPort: {
            id: '${appGateway.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostNames: []
          requireServerNameIndication: false
          customErrorConfigurations: []
        }
      }
      {
        name: 'frontend-listener'
        id: '${appGateway.id}/httpListeners/frontend-listener'
        properties: {
          frontendIPConfiguration: {
            id: '${appGateway.id}/frontendIPConfigurations/appGwPublicFrontendIpIPv4'
          }
          frontendPort: {
            id: '${appGateway.id}/frontendPorts/port_81'
          }
          protocol: 'Http'
          hostNames: []
          requireServerNameIndication: false
          customErrorConfigurations: []
        }
      }
    ]
    listeners: []
    urlPathMaps: [
      {
        name: 'Path-based-routing'
        id: '${appGateway.id}/urlPathMaps/Path-based-routing'
        properties: {
          defaultBackendAddressPool: {
            id: '${appGateway.id}/backendAddressPools/${appGatewayName}-frontend-pool'
          }
          defaultBackendHttpSettings: {
            id: '${appGateway.id}/backendHttpSettingsCollection/${appGatewayName}-frontend-setting'
          }
          pathRules: [
            {
              name: 'api-route'
              id: '${appGateway.id}/urlPathMaps/Path-based-routing/pathRules/api-route'
              properties: {
                paths: [
                  '/api/*'
                ]
                backendAddressPool: {
                  id: '${appGateway.id}/backendAddressPools/${appGatewayName}-backend-pool'
                }
                backendHttpSettings: {
                  id: '${appGateway.id}/backendHttpSettingsCollection/${appGatewayName}-backend-setting'
                }
              }
            }
          ]
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'Path-based-routing'
        id: '${appGateway.id}/requestRoutingRules/Path-based-routing'
        properties: {
          ruleType: 'PathBasedRouting'
          priority: 100
          httpListener: {
            id: '${appGateway.id}/httpListeners/${appGatewayName}-listener1'
          }
          urlPathMap: {
            id: '${appGateway.id}/urlPathMaps/Path-based-routing'
          }
        }
      }
    ]
    routingRules: []
    probes: [
      {
        name: 'health'
        id: '${appGateway.id}/probes/health'
        properties: {
          protocol: 'Http'
          path: '/api/drive/health'
          interval: 30
          timeout: 30
          unhealthyThreshold: 3
          pickHostNameFromBackendHttpSettings: true
          enableProbeProxyProtocolHeader: false
          minServers: 0
          match: {
            statusCodes: [
              '200-399'
            ]
          }
        }
      }
      {
        name: 'healthSec'
        id: '${appGateway.id}/probes/healthSec'
        properties: {
          protocol: 'Https'
          path: '/api/drive/health'
          interval: 30
          timeout: 30
          unhealthyThreshold: 3
          pickHostNameFromBackendHttpSettings: true
          enableProbeProxyProtocolHeader: false
          minServers: 0
          match: {
            statusCodes: [
              '200-399'
            ]
          }
        }
      }
    ]
    rewriteRuleSets: []
    redirectConfigurations: []
    privateLinkConfigurations: []
    entraJWTValidationConfigs: []
    enableHttp2: true
    enableFIPS: false
    forceFirewallPolicyAssociation: true
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 3
    }
    firewallPolicy: {
      id: wafPolicyId
    }
  }
}
