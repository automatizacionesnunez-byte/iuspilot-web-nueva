$files = Get-ChildItem -Path "c:\Users\Usuario\.gemini\antigravity\playground\iuspilot-premium" -Filter "*.html"

# Patrón para eliminar el enlace a calculadoras.html del menú de navegación
$navPattern = '(?s)<a [^>]*href="calculadoras.html"[^>]*>Calculadoras</a>'

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match $navPattern) {
        $newContent = $content -replace $navPattern, ""
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Removed Calculadoras link from $($file.Name)"
    }
}
