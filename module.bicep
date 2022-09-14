param keyVaultRGName string = 'rg-weu-prod'
param keyVaultName string = 'kvsql30'
param adminLogin string
param location string
param projectName string

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: keyVaultName
  scope: resourceGroup(keyVaultRGName )
}

module sql 'main.bicep' = {
  name: 'deploySQL'
  params: {
    location: location
    administratorLogin: adminLogin
    administratorLoginPassword: kv.getSecret('passwordSql')
    environmentType: 'prod'
    projectName: projectName
  }
}
