# check AzureRM module is installed
Get-Module -ListAvailable AzureRM



# log in to azure
Connect-AzureRmAccount



# create a resource group
New-AzureRmResourceGroup -Name containersdemo -Location eastus



# create registry
New-AzureRMContainerRegistry -ResourceGroupName containersdemo `
    -Name TestContainerRegistry01 -EnableAdminUser -Sku Basic



# get registry details
$Registry = Get-AzureRmContainerRegistry -ResourceGroupName "containersdemo" -Name "TestContainerRegistry01"



# get registry credentails
$RegistryCredential = Get-AzureRmContainerRegistryCredential `
    -ResourceGroupName "containersdemo" -Name "TestContainerRegistry01"



# log into registry
docker login $Registry.LoginServer -u $$RegistryCredential.Username -p $RegistryCredential.Password



# list local docker images
docker images



# build custom image
docker build -t testimage C:\git\dbafromthecold\ContainersInTheCloud\Code



# tag local image with ACR name
docker tag testimage TestContainerRegistry01.azurecr.io/devsqlimage:latest



# push image to registry
docker push TestContainerRegistry01.azurecr.io/devsqlimage:latest



# view registry
Get-AzureRmContainerRegistry `
    -ResourceGroupName containersdemo -Name TestContainerRegistry01 `
        -IncludeDetail



# remove registry
Remove-AzureRmContainerRegistry -ResourceGroupName containersdemo -Name TestContainerRegistry