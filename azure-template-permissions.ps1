echo ${Env:resourceGroupText}
Connect-AzureAD -Confirm
Install-Module -Name Az.ManagedServiceIdentity -Force

$msiName          = ${Env:identityName}
$msiObjectId      = ${Env:msiObjectId}
$msiResourceGroup = ${Env:resourceGroupName} 

$GraphAppId  = (Get-AzUserAssignedIdentity -ResourceGroupName $msiResourceGroup -Name $msiName).PrincipalId

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter 'appId eq `$GraphAppId`'
$PermissionName        = 'Application.ReadWrite.OwnedBy'        

$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}
New-AzureAdServiceAppRoleAssignment -ObjectId $msiObjectId -PrincipalId $msiObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id