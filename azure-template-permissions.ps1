# Trusted configuration for PSGallery enable us to install required cmdlets without -Force tag
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

echo ${Env:identityName}
echo ${Env:msiObjectId}
echo ${Env:resourceGroupText}

Install-Module -Name Az.ManagedServiceIdentity -RequiredVersion 0.7.2 -Confirm:$false

echo "----------------------------------------------"
echo "----------------------------------------------"

$msiName          = ${Env:identityName}
$msiObjectId      = ${Env:msiObjectId}
$msiResourceGroup = ${Env:resourceGroupText}
$identity         = Get-AzUserAssignedIdentity -ResourceGroupName $msiResourceGroup -Name $msiName

echo $identity;
echo "----------------------------------------------"
echo "----------------------------------------------"

$GraphAppId  = (Get-AzUserAssignedIdentity -ResourceGroupName $msiResourceGroup -Name $msiName).PrincipalId

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter 'appId eq `$GraphAppId`'
$PermissionName        = 'Application.ReadWrite.OwnedBy'

$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}
New-AzureAdServiceAppRoleAssignment -ObjectId $msiObjectId -PrincipalId $msiObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id