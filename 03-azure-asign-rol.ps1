$appName = "CodeXMakerSalesApp"
$appURI = "https://www.gethypercube.com"
$appHomePageUrl = "https://www.gethypercube.com"
$appReplyURLs = @($appURI, $appHomePageURL, "https://www.gethypercube.com")
$

New-AzIdentityAssign -DisplayName $appName -IdentifierUris $appURI -Homepage $appHomePageUrl    
