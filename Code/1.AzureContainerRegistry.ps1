# check AzureRM module is installed
Get-Module -ListAvailable AzureRM



# log in to azure
Connect-AzureRmAccount



# create a resource group
New-AzureRmResourceGroup -Name containers1 -Location eastus



# create registry
New-AzureRMContainerRegistry -ResourceGroupName containers1 `
    -Name TestContainerRegistry01 -EnableAdminUser -Sku Basic



# get registry details
Get-AzureRmContainerRegistryCredential -Registry TestContainerRegistry01



# log into registry
docker login <<LOGINSERVER>> -u <<USERNAME>>



# list local docker images
docker images



# build custom image
docker build -t testimage C:\git\dbafromthecold\ContainersInTheCloud\Code



# tag local image with ACR name
docker tag testimage TestContainerRegistry01.azurecr.io/devsqlimage:latest



# push image to registry
docker push TestContainerRegistry01.azurecr.io/devsqlimage:latest



# view registry
Get-AzureRmContainerRegistry -ResourceGroupName containers1 -Name TestContainerRegistry



# show repository



# remove registry
Remove-AzureRmContainerRegistry -ResourceGroupName containers1 -Name TestContainerRegistry