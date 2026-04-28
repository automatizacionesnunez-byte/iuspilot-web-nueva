$files = Get-ChildItem -Filter *.html
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Insert Login link before any "Prueba Gratis" button
    # Look for the pattern of the button
    $pattern = '(<button[^>]*>Prueba Gratis</button>)'
    $replacement = '<a href="https://ius-pilot-ai.lovable.app/login" class="text-on-surface font-semibold text-xs md:text-sm hover:text-primary transition-colors">Acceder</a>$1'
    
    # Also ensure we have a flex container with gaps
    # If the button is wrapped in a div, we might want to put the link inside that div
    
    if ($content -match $pattern) {
        # Check if the button is already preceded by "Acceder" to avoid double insertion
        if ($content -notlike "*Acceder*Prueba Gratis*") {
            $newContent = [regex]::Replace($content, $pattern, $replacement)
            
            # Additional fix: if there's no gap between the new link and button, we might need a wrapper or margin
            # But usually they are inside a flex container or we can add a gap class
            
            Set-Content $file.FullName $newContent
            Write-Host "Updated $($file.Name)"
        }
    }
}
