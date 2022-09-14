@allowed([
  'prod'
  'dev'
])
param environmentType string

param projectName string
param location string
param locationName string = 'weu'

@secure()
param administratorLogin string
@secure()
param administratorLoginPassword string

var serverName = 'sql${projectName}${locationName}${environmentType}'
var sqlDBName = 'db${projectName}${locationName}${environmentType}'

resource server 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  name: '${server.name}/${sqlDBName}'
  location: location
  sku: {
    name: 'S3'
    tier: 'Standard'
  }
}
