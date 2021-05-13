$msiName="Samuel Vazquez Ruiz"
$msiObjectId = "f4cf341c-c919-4e19-896f-d971ca730ef4"
# Windows Azure Active Directory
$GraphAppId = "00000002-0000-0000-c000-000000000000" 
$GraphServicePrincipal = Get-AzureADServicePrincipal `
        -Filter "appId eq '$GraphAppId'"

$PermissionName = "Application.ReadWrite.OwnedBy"
$AppRole = $GraphServicePrincipal.AppRoles  `
       | Where-Object {$_.Value -eq $PermissionName `
       -and $_.AllowedMemberTypes -contains "Application"}
       
New-AzureAdServiceAppRoleAssignment `
    -ObjectId $msiObjectId `
    -PrincipalId $msiObjectId  `
    -ResourceId $GraphServicePrincipal.ObjectId `
    -Id $AppRole.Id  