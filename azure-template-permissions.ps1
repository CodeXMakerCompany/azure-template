# Trusted configuration for PSGallery enable us to install required cmdlets without -Force tag
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name Az -Confirm:$false
Import-Module Az

echo $PSVersionTable.PSVersion
echo "----------------------------------------------"
echo "----------------------------------------------"

$msiName          = ${Env:identityName}
$msiObjectId      = ${Env:msiObjectId}
$msiResourceGroup = ${Env:groupName}
$GraphAppId       = ${Env:graphAppId}
$PermissionName   = 'Application.ReadWrite.OwnedBy'

$Credential = Get-Credential
Connect-AzAccount -Credential $Credential

echo Get-AzADServicePrincipal

# $GraphServicePrincipal = Get-AzADServicePrincipal -Filter 'appId eq `$GraphAppId`'

# echo "----------------------------------------------"
# echo "----------------------------------------------"

# $AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}
# New-AzureAdServiceAppRoleAssignment -ObjectId $msiObjectId -PrincipalId $msiObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id