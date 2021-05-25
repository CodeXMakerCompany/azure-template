Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

Connect-AzAccount

$msiName="Samuel Vazquez Ruiz"
$msiObjectId = "f4cf341c-c919-4e19-896f-d971ca730ef4"
# Windows Azure Active Directory
$ObjId = "92bc69e9-7f51-408f-807b-0dd3c2264289"

$role= "contribuitor"
$subcription= "/subscriptions/2185a8bd-f4a6-45b0-84c5-0627fd10d13e/resourceGroups/arg-introduction-01"
$GraphServicePrincipal = Get-AzADServicePrincipal `
        -ObjectId "'$ObjId'"

$PermissionName = "Application.ReadWrite.OwnedBy"
$AppRole = $GraphServicePrincipal.AppRoles  `
       | Where-Object {$_.Value -eq $PermissionName `
       -and $_.AllowedMemberTypes -contains "Application"}
       
Update-AzADServicePrincipal `
    -ObjectId $msiObjectId `
    -ApplicationId $AppRole.Id  `
    -ResourceId $GraphServicePrincipal.ObjectId `

$Guid = New-Guid
$startDate = Get-Date
$PasswordCredential = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordCredential

$appName = "CodeXMakerSalesApp"
$appURI = "https://www.gethypercube.com"
$appHomePageUrl = "https://www.gethypercube.com"
$appReplyURLs = @($appURI, $appHomePageURL, "https://www.gethypercube.com")

if(!($myApp = Get-AzADApplication -IdentifierUri "'$($appURI)'"  -ErrorAction SilentlyContinue))
{
    $myApp = New-AzADApplication -DisplayName $appName -IdentifierUris $appURI -Homepage $appHomePageUrl    
}


