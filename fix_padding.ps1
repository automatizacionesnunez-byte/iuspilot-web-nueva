$files = Get-ChildItem -Filter *.html
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Update main padding-top if it's too small for h-24
    $content = [regex]::Replace($content, 'pt-16', 'pt-24')
    # Some files use pt-24 already, maybe they need more?
    $content = [regex]::Replace($content, 'pt-24 md:pt-32', 'pt-32 md:pt-40')
    
    Set-Content $file.FullName $content
    Write-Host "Updated $($file.Name)"
}
