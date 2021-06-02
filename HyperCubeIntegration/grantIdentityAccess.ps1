#7a64b907-85ba-428c-880b-9f4027ae48ba

# Trusted configuration for PSGallery enable us to install required cmdlets without -Force tag
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name AzureAD -Force

$msiName="HypercubeIdentity2"
$msiObjectId = Read-Host -Prompt 'Input the HyperIdentity objectId: '
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