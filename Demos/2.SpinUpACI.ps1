# check AzureRM module is installed
Get-Module -ListAvailable AzureRM



# log in to azure
Connect-AzureRmAccount



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
Get-AzureRmContainerGroup -ResourceGroupName containers1 -Name testcontainer2



# get container logs
Get-AzureRmContainerInstanceLog --ResourceGroupName containers1 -ContainerGroupName testcontainers2



# have a look at the other container
Get-AzureRmContainerGroup -ResourceGroupName containers1 -Name testcontainer1



# confirm container created
Get-AzureRmContainerGroup -ResourceGroupName containers1 -Name testcontainer2



# get container logs
Get-AzureRmContainerInstanceLog --ResourceGroupName containers1 -ContainerGroupName testcontainers2



# delete container
Remove-AzureRmContainerGroup -ResourceGroupName containers1 -Name testcontainer2

