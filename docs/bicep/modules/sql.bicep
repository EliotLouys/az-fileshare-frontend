param location string
param serverName string

@secure()
param vulnerabilityAssessments_Default_storageContainerPath string

resource sqlServer 'Microsoft.Sql/servers@2024-11-01-preview' = {
  name: serverName
  location: location
  kind: 'v12.0'
  properties: {
    administratorLogin: 'az-fileshare-sql-admin'
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    retentionDays: -1
  }
}

resource serverName_Default 'Microsoft.Sql/servers/advancedThreatProtectionSettings@2024-11-01-preview' = {
  parent: sqlServer
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource serverName_CreateIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: sqlServer
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource serverName_DbParameterization 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: sqlServer
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource serverName_DefragmentIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: sqlServer
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource serverName_DropIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: sqlServer
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource serverName_ForceLastGoodPlan 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: sqlServer
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
}

resource Microsoft_Sql_servers_auditingPolicies_serverName_Default 'Microsoft.Sql/servers/auditingPolicies@2014-04-01' = {
  parent: sqlServer
  name: 'Default'
  location: location
  properties: {
    auditingState: 'Disabled'
  }
}

resource Microsoft_Sql_servers_auditingSettings_serverName_Default 'Microsoft.Sql/servers/auditingSettings@2024-11-01-preview' = {
  parent: sqlServer
  name: 'default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Sql_servers_connectionPolicies_serverName_default 'Microsoft.Sql/servers/connectionPolicies@2024-11-01-preview' = {
  parent: sqlServer
  name: 'default'
  location: location
  properties: {
    connectionType: 'Default'
  }
}

resource serverName_az_fileshare_sql_db 'Microsoft.Sql/servers/databases@2024-11-01-preview' = {
  parent: sqlServer
  name: 'az-fileshare-sql-db'
  location: location
  sku: {
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 1
  }
  kind: 'v12.0,user,vcore,serverless'
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 34359738368
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    autoPauseDelay: 60
    requestedBackupStorageRedundancy: 'Local'
    minCapacity: json('0.5')
    maintenanceConfigurationId: '/subscriptions/c54cecda-aad7-4506-9a2b-dc4ee88fe2ef/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    isLedgerOn: false
    availabilityZone: 'NoPreference'
  }
}

resource serverName_master_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2024-11-01-preview' = {
  name: '${serverName}/master/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_serverName_master_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  name: '${serverName}/master/Default'
  location: location
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_serverName_master_Default 'Microsoft.Sql/servers/databases/auditingSettings@2024-11-01-preview' = {
  name: '${serverName}/master/Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_serverName_master_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2024-11-01-preview' = {
  name: '${serverName}/master/Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_serverName_master_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2024-11-01-preview' = {
  name: '${serverName}/master/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource serverName_master_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2024-11-01-preview' = {
  name: '${serverName}/master/Current'
  properties: {}
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_serverName_master_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2024-11-01-preview' = {
  name: '${serverName}/master/Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_serverName_master_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2024-11-01-preview' = {
  name: '${serverName}/master/Current'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_serverName_master_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2024-11-01-preview' = {
  name: '${serverName}/master/Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_devOpsAuditingSettings_serverName_Default 'Microsoft.Sql/servers/devOpsAuditingSettings@2024-11-01-preview' = {
  parent: sqlServer
  name: 'Default'
  properties: {
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource serverName_current 'Microsoft.Sql/servers/encryptionProtector@2024-11-01-preview' = {
  parent: sqlServer
  name: 'current'
  kind: 'servicemanaged'
  properties: {
    serverKeyName: 'ServiceManaged'
    serverKeyType: 'ServiceManaged'
    autoRotationEnabled: false
  }
}

resource Microsoft_Sql_servers_extendedAuditingSettings_serverName_Default 'Microsoft.Sql/servers/extendedAuditingSettings@2024-11-01-preview' = {
  parent: sqlServer
  name: 'default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource serverName_AllowAllWindowsAzureIps 'Microsoft.Sql/servers/firewallRules@2024-11-01-preview' = {
  parent: sqlServer
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource serverName_ClientIp_2026_4_9_10_6_21 'Microsoft.Sql/servers/firewallRules@2024-11-01-preview' = {
  parent: sqlServer
  name: 'ClientIp-2026-4-9_10-6-21'
  properties: {
    startIpAddress: '77.135.189.178'
    endIpAddress: '77.135.189.178'
  }
}

resource serverName_ServiceManaged 'Microsoft.Sql/servers/keys@2024-11-01-preview' = {
  parent: sqlServer
  name: 'ServiceManaged'
  kind: 'servicemanaged'
  properties: {
    serverKeyType: 'ServiceManaged'
  }
}

resource Microsoft_Sql_servers_securityAlertPolicies_serverName_Default 'Microsoft.Sql/servers/securityAlertPolicies@2024-11-01-preview' = {
  parent: sqlServer
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
}

resource Microsoft_Sql_servers_sqlVulnerabilityAssessments_serverName_Default 'Microsoft.Sql/servers/sqlVulnerabilityAssessments@2024-11-01-preview' = {
  parent: sqlServer
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource Microsoft_Sql_servers_vulnerabilityAssessments_serverName_Default 'Microsoft.Sql/servers/vulnerabilityAssessments@2024-11-01-preview' = {
  parent: sqlServer
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
    storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
  }
}


resource serverName_az_fileshare_sql_db_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource serverName_az_fileshare_sql_db_CreateIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: serverName_az_fileshare_sql_db
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource serverName_az_fileshare_sql_db_DbParameterization 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: serverName_az_fileshare_sql_db
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource serverName_az_fileshare_sql_db_DefragmentIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: serverName_az_fileshare_sql_db
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource serverName_az_fileshare_sql_db_DropIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: serverName_az_fileshare_sql_db
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource serverName_az_fileshare_sql_db_ForceLastGoodPlan 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: serverName_az_fileshare_sql_db
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_serverName_az_fileshare_sql_db_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  parent: serverName_az_fileshare_sql_db
  name: 'default'
  location: location
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_serverName_az_fileshare_sql_db_Default 'Microsoft.Sql/servers/databases/auditingSettings@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_backupLongTermRetentionPolicies_serverName_az_fileshare_sql_db_default 'Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'default'
  properties: {
    timeBasedImmutability: 'Disabled'
    weeklyRetention: 'PT0S'
    monthlyRetention: 'PT0S'
    yearlyRetention: 'PT0S'
    weekOfYear: 0
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_backupShortTermRetentionPolicies_serverName_az_fileshare_sql_db_default 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'default'
  properties: {
    retentionDays: 7
    diffBackupIntervalInHours: 12
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_serverName_az_fileshare_sql_db_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_serverName_az_fileshare_sql_db_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource serverName_az_fileshare_sql_db_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'Current'
  properties: {}
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_serverName_az_fileshare_sql_db_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_serverName_az_fileshare_sql_db_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'Current'
  properties: {
    state: 'Enabled'
  }
  dependsOn: [
    sqlServer
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_serverName_az_fileshare_sql_db_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2024-11-01-preview' = {
  parent: serverName_az_fileshare_sql_db
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
  dependsOn: [
    sqlServer
  ]
}



