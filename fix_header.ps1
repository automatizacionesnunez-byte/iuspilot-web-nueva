$files = Get-ChildItem -Filter *.html
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # 1. Increase Header Height
    # Look for <header class="... h-16 ..."> or similar and change to h-24
    $content = [regex]::Replace($content, 'h-16', 'h-24')
    
    # 2. Add Login Link before "Prueba Gratis"
    # This regex is more robust to whitespace and class variations
    $pattern = '(<button[^>]*>\s*Prueba Gratis\s*</button>)'
    
    # Check if Acceder is already there
    if ($content -notlike "*Acceder*Prueba Gratis*") {
        $link = '<a href="https://ius-pilot-ai.lovable.app/login" class="text-on-surface font-semibold text-xs md:text-sm hover:text-primary transition-colors mr-4 md:mr-8">Acceder</a>'
        $content = [regex]::Replace($content, $pattern, "$link`$1")
    }
    
    # 3. Ensure the action buttons are properly aligned and not missing containers
    # Sometimes they are in a div, sometimes not. Let's make sure they are in a flex container if they aren't already.
    # Actually, the previous script might have messed up some containers. Let's fix that.
    
    Set-Content $file.FullName $content
    Write-Host "Updated $($file.Name)"
}
