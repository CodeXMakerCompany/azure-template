# Trusted configuration for PSGallery enable us to install required cmdlets without -Force tag
#Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
#Install-Module -Name Az -Confirm:$false -Force
#Import-Module Az


echo "----------------------------------------------"
echo "----------------------------------------------"

$msiName          = ${Env:identityName}
$msiObjectId      = ${Env:msiObjectId}
$msiResourceGroup = ${Env:groupName}
$GraphAppId       = ${Env:graphAppId}
$PermissionName   = 'Application.ReadWrite.OwnedBy'


$GraphServicePrincipal = Get-AzADServicePrincipal -Filter 'appId eq `$GraphAppId`'

$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}
New-AzureAdServiceAppRoleAssignment -ObjectId $msiObjectId -PrincipalId $msiObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id