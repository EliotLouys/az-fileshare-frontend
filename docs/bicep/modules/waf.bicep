param location string
param wafPolicyName string

output wafPolicyId string = wafPolicy.id

resource wafPolicy 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2025-05-01' = {
  name: wafPolicyName
  location: location
  properties: {
    customRules: [
      {
        name: 'AllowGoodTraffic'
        priority: 1
        ruleType: 'MatchRule'
        action: 'Allow'
        matchConditions: [
          {
            matchVariables: [
              {
                variableName: 'RequestUri'
              }
            ]
            operator: 'Contains'
            negationConditon: false
            matchValues: [
              '/login'
              '/assets/'
            ]
            transforms: []
          }
        ]
        state: 'Enabled'
      }
    ]
    policySettings: {
      requestBodyCheck: true
      maxRequestBodySizeInKb: 128
      fileUploadLimitInMb: 100
      state: 'Enabled'
      mode: 'Prevention'
      customBlockResponseStatusCode: 403
      jsChallengeCookieExpirationInMins: 30
      requestBodyInspectLimitInKB: 128
      fileUploadEnforcement: true
      requestBodyEnforcement: false
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'OWASP'
          ruleSetVersion: '3.2'
          ruleGroupOverrides: [
            {
              ruleGroupName: 'General'
              rules: [
                {
                  ruleId: '200002'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '200003'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '200004'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
              rules: [
                {
                  ruleId: '911100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
              rules: [
                {
                  ruleId: '913100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '913101'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '913102'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '913110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '913120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
              rules: [
                {
                  ruleId: '920100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920121'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920171'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920201'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920202'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920220'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920230'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920240'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920250'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920260'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920270'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920271'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920272'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920273'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920274'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920280'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920290'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920300'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920310'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920311'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920320'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920330'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920340'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920341'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920350'
                  state: 'Disabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920420'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920430'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920440'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920450'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920460'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920470'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920480'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
              rules: [
                {
                  ruleId: '921110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921151'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
              rules: [
                {
                  ruleId: '930100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '930110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '930120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '930130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
              rules: [
                {
                  ruleId: '931100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '931110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '931120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '931130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
              rules: [
                {
                  ruleId: '932100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932105'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932106'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932115'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932171'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
              rules: [
                {
                  ruleId: '933100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933111'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933131'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933151'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933161'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
              rules: [
                {
                  ruleId: '941100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941101'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941220'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941230'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941240'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941250'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941260'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941270'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941280'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941290'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941300'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941310'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941320'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941330'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941340'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941350'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941360'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
              rules: [
                {
                  ruleId: '942100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942200'
                  state: 'Disabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942220'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942230'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942240'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942250'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942251'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942260'
                  state: 'Disabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942270'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942280'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942290'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942300'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942310'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942320'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942330'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942340'
                  state: 'Disabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942350'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942360'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942361'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942370'
                  state: 'Disabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942380'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942390'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942400'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942410'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942420'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942421'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942430'
                  state: 'Disabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942431'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942432'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942440'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942450'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942460'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942470'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942480'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942490'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942500'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
              rules: [
                {
                  ruleId: '943100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '943110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '943120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
              rules: [
                {
                  ruleId: '944100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944240'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944250'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'Known-CVEs'
              rules: [
                {
                  ruleId: '800100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800111'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800112'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800113'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800114'
                  state: 'Enabled'
                  action: 'Log'
                }
                {
                  ruleId: '800115'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
          ]
        }
      ]
      exclusions: []
    }
  }
}

