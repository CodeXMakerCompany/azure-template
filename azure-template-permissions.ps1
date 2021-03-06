# Trusted configuration for PSGallery enable us to install required cmdlets without -Force tag
#Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
#Install-Module -Name Az -Confirm:$false -Force
#Import-Module Az
$msiName          = ${Env:identityName}
$msiObjectId      = ${Env:msiObjectId}
$msiResourceGroup = ${Env:groupName}
$GraphAppId       = ${Env:graphAppId}
$PermissionName   = 'Application.ReadWrite.OwnedBy'

echo "----------------------------------------------"

$GraphServicePrincipal = Get-AzADServicePrincipal -ApplicationId $GraphAppId

echo $GraphAppId
echo "----------------------------------------------"

$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}

echo $AppRole
echo "----------------------------------------------"

New-AzureAdServiceAppRoleAssignment -ObjectId $msiObjectId -PrincipalId $msiObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id