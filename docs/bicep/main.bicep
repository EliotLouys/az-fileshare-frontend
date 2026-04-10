// ─── Parameters ───────────────────────────────────────────────────────────────

@secure()
param vulnerabilityAssessments_Default_storageContainerPath string

param location string = 'switzerlandnorth'

// Identity
param loadtests_AzFileshareLoadTesting_name string = 'AzFileshareLoadTesting'
param userAssignedIdentities_az_fileshare_bac_id_8c65_name string = 'az-fileshare-bac-id-8c65'
param userAssignedIdentities_az_fileshare_fro_id_9ce1_name string = 'az-fileshare-fro-id-9ce1'

// Network
param virtualNetworks_az_fileshare_virtual_network_name string = 'az-fileshare-virtual-network'
param publicIPAddresses_az_fileshare_application_gateway_frontend_ip_name string = 'az-fileshare-application-gateway-frontend-ip'

// WAF + App Gateway
param ApplicationGatewayWebApplicationFirewallPolicies_az_fileshare_waf_policy_name string = 'az-fileshare-waf-policy'
param applicationGateways_az_fileshare_application_gateway_name string = 'az-fileshare-application-gateway'

// Monitoring
param workspaces_LogWorkspace_name string = 'LogWorkspace'

// SQL
param servers_az_fileshare_sql_db_server_name string = 'az-fileshare-sql-db-server'

// Storage
param storageAccounts_azfileshareblobstorage_name string = 'azfileshareblobstorage'

// App Service
param serverfarms_ASP_azfileshare_8274_name string = 'ASP-azfileshare-8274'
param autoscalesettings_ASP_azfileshare_8274_Autoscale_46_name string = 'ASP-azfileshare-8274-Autoscale-46'
param sites_az_fileshare_backend_name string = 'az-fileshare-backend'
param sites_az_fileshare_frontend_name string = 'az-fileshare-frontend'

// ─── Modules ──────────────────────────────────────────────────────────────────

module identity 'modules/identity.bicep' = {
  name: 'identity'
  params: {
    location: location
    loadTestName: loadtests_AzFileshareLoadTesting_name
    bacIdentityName: userAssignedIdentities_az_fileshare_bac_id_8c65_name
    froIdentityName: userAssignedIdentities_az_fileshare_fro_id_9ce1_name
  }
}

module network 'modules/network.bicep' = {
  name: 'network'
  params: {
    location: location
    vnetName: virtualNetworks_az_fileshare_virtual_network_name
    publicIpName: publicIPAddresses_az_fileshare_application_gateway_frontend_ip_name
  }
}

module waf 'modules/waf.bicep' = {
  name: 'waf'
  params: {
    location: location
    wafPolicyName: ApplicationGatewayWebApplicationFirewallPolicies_az_fileshare_waf_policy_name
  }
}

module appgateway 'modules/appgateway.bicep' = {
  name: 'appgateway'
  params: {
    location: location
    appGatewayName: applicationGateways_az_fileshare_application_gateway_name
    publicIpId: network.outputs.publicIpId
    wafPolicyId: waf.outputs.wafPolicyId
  }
}

module monitoring 'modules/monitoring.bicep' = {
  name: 'monitoring'
  params: {
    location: location
    workspaceName: workspaces_LogWorkspace_name
  }
}

module sql 'modules/sql.bicep' = {
  name: 'sql'
  params: {
    location: location
    serverName: servers_az_fileshare_sql_db_server_name
    vulnerabilityAssessments_Default_storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
  }
}

module storage 'modules/storage.bicep' = {
  name: 'storage'
  params: {
    location: location
    storageAccountName: storageAccounts_azfileshareblobstorage_name
  }
}

module appservice 'modules/appservice.bicep' = {
  name: 'appservice'
  params: {
    location: location
    serverFarmName: serverfarms_ASP_azfileshare_8274_name
    autoscaleName: autoscalesettings_ASP_azfileshare_8274_Autoscale_46_name
    backendSiteName: sites_az_fileshare_backend_name
    frontendSiteName: sites_az_fileshare_frontend_name
  }
}
