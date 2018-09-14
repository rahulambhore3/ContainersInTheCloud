# check AzureRM module is installed
Get-Module -ListAvailable AzureRM



# log in to azure
Connect-AzureRmAccount



# list registries under resource group
Get-AzureRmContainerRegistry -ResourceGroupName containers1 -Name TestContainerRegistry



# Enable admin on registry
Update-AzureRmContainerRegistry -ResourceGroupName containers1 -Name TestContainerRegistry -EnableAdminUser



# Get credentials
Get-AzureRmContainerRegistryCredential -Registry TestContainerRegistry01



# create keyvault
New-AzureRmKeyVault -Name aptestkeyvault01 -ResourceGroupName containers1



# store password in keyvault
Set-AzureKeyVaultSecret `
   -VaultName aptestkeyvault01 `
   -Name testcontainerregistry01-pull-pwd `
   -SecretValue $(New-AzureRmADServicePrincipal `
                    -DisplayName testcontainerregistry01-pull `
                    -Scope (GET ID OF ACR) `
                    -Role reader `
                    -query password)



# store username in keyvault
Set-AzureKeyVaultSecret `
    -VaultName aptestkeyvault01 `
    -Name testcontainerregistry01-pull-usr `
    -SecretValue $(Get-AzureRmADServicePrincipal DETAILS)



# create container
New-AzureRmContainerGroup
    -ResourceGroupName containers1
    -Name testcontainer1
    -Image testcontainerregistry01.azurecr.io/devsqlimage:latest
    -RegistryCredential ????
    -Cpu 2
    -MemoryInGB 4
    -IpAddressType public
    -Port 1433
    -EnvironmentVariable     



# confirm container created
Get-AzureRmContainerGroup -ResourceGroupName containers1 -Name testcontainer1



# get container logs
Get-AzureRmContainerInstanceLog --ResourceGroupName containers1 -ContainerGroupName testcontainers1




# delete container
az container delete --name testcontainer1 --resource-group containers1
Remove-AzureRmContainerGroup -ResourceGroupName containers1 -Name testcontainer1
