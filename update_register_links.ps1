$files = Get-ChildItem -Filter *.html
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Target any button that contains "Prueba Gratis"
    # We'll convert it to an <a> tag keeping the same classes
    $pattern = '(?s)<button([^>]*)>\s*(Prueba Gratis[^<]*)\s*</button>'
    $replacement = '<a href="https://ius-pilot-ai.lovable.app/register"$1>$2</a>'
    
    $newContent = [regex]::Replace($content, $pattern, $replacement)
    
    if ($newContent -ne $content) {
        Set-Content $file.FullName $newContent
        Write-Host "Updated $($file.Name)"
    }
}
