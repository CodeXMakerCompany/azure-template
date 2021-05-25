$appName = "CodeXMakerSalesApp"
$appURI = "https://www.gethypercube.com"
$appHomePageUrl = "https://www.gethypercube.com"
$appReplyURLs = @($appURI, $appHomePageURL, "https://www.gethypercube.com")
if(!($myApp = Get-AzADApplication -IdentifierUri "'$($appURI)'"  -ErrorAction SilentlyContinue))
{
    $myApp = New-AzADApplication -DisplayName $appName -IdentifierUris $appURI -Homepage $appHomePageUrl    
}