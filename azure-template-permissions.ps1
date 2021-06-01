# Trusted configuration for PSGallery enable us to install required cmdlets without -Force tag
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name AzureAD -Confirm:$false

echo ${Env:groupName}
echo ${Env:identityName}
echo ${Env:msiObjectId}
echo ${Env:graphAppId}
echo ${Env:subscription}

echo "----------------------------------------------"
echo "----------------------------------------------"

$msiName          = ${Env:identityName}
$msiObjectId      = ${Env:msiObjectId}
$msiResourceGroup = ${Env:groupName}

$GraphAppId  = ${Env:graphAppId}

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter 'appId eq `$GraphAppId`'
$PermissionName        = 'Application.ReadWrite.OwnedBy'

echo "----------------------------------------------"
echo "----------------------------------------------"

$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}
New-AzureAdServiceAppRoleAssignment -ObjectId $msiObjectId -PrincipalId $msiObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id