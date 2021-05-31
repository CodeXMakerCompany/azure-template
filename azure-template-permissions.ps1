$msiName          = ${Env:identityName}
$msiObjectId      = ${Env:msiObjectId}
$msiResourceGroup = ${Env:resourceGroupText}

$GraphAppId  = (Get-AzUserAssignedIdentity -ResourceGroupName $msiResourceGroup -Name $msiName).PrincipalId

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter 'appId eq `$GraphAppId`'
$PermissionName        = 'Application.ReadWrite.OwnedBy'

$AppRole = $GraphServicePrinci  pal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}
New-AzureAdServiceAppRoleAssignment -ObjectId $msiObjectId -PrincipalId $msiObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id