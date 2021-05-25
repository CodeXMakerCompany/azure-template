$template = 'azure-template.json'

New-AzDeployment `
-Location "West US" `
-TemplateFile $template `
-TemplateVersion "2.1" `