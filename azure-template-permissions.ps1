echo ${Env:subscription}

# Trusted configuration for PSGallery enable us to install required cmdlets without -Force tag
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Install-Module -Name Az.ManagedServiceIdentity -RequiredVersion 0.7.2 -Confirm:$false
Connect-AzAccount -Identity -Subscription:${Env:subscription}

$msiName          = ${Env:identityName}
$msiObjectId      = ${Env:msiObjectId}
$msiResourceGroup = ${Env:resourceGroupText}

$GraphAppId  = (Get-AzUserAssignedIdentity -ResourceGroupName $msiResourceGroup -Name $msiName).PrincipalId

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter 'appId eq `$GraphAppId`'
$PermissionName        = 'Application.ReadWrite.OwnedBy'

$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}
New-AzureAdServiceAppRoleAssignment -ObjectId $msiObjectId -PrincipalId $msiObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id