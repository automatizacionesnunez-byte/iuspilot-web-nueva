$files = Get-ChildItem -Path "c:\Users\Usuario\.gemini\antigravity\playground\iuspilot-premium" -Filter "*.html"

# Pattern robusto para capturar las variaciones del logo (Gavel + Texto)
$pattern = '(?s)<div class="flex items-center[^"]*">\s*(<div[^>]*>\s*)?<span class="material-symbols-outlined[^>]*" data-icon="gavel">gavel</span>\s*(</div>\s*)?<span class="[^"]*">IusPilot</span>\s*</div>'

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Determinar si es un footer (bg oscuro) para aplicar filtros si es necesario
    # Pero por ahora usaremos la imagen tal cual, ajustando la clase
    $replacement = '<a href="index.html" class="flex items-center group"><img src="images/logo-iuspilot.png" alt="IusPilot Logo" class="h-10 w-auto group-hover:opacity-80 transition-opacity"></a>'
    
    $newContent = [regex]::Replace($content, $pattern, $replacement)
    
    if ($newContent -ne $content) {
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated $($file.Name)"
    } else {
        Write-Host "No match in $($file.Name)"
    }
}
