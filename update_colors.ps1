$files = Get-ChildItem -Path "c:\Users\Usuario\.gemini\antigravity\playground\iuspilot-premium" -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $newContent = $content
    
    # Reemplazo de color primario anterior por el nuevo rojo solicitado
    $newContent = $newContent -replace '#d20000', '#C74E4E'
    $newContent = $newContent -replace 'rgb\(210,\s*0,\s*0\)', '#C74E4E'
    
    # Reemplazo de colores de acento/gradientes por versiones armonizadas con el nuevo rojo
    $newContent = $newContent -replace '#ff4d4d', '#E28C8C'
    
    # Inyectar primary-dark para énfasis en la config de Tailwind
    if ($newContent -match '"primary": "#C74E4E"' -and -not ($newContent -match '"primary-dark": "#540202"')) {
        $newContent = $newContent -replace '"primary": "#C74E4E"', '"primary": "#C74E4E", "primary-emphasis": "#540202"'
    }
    
    # Actualizar gradientes específicos en los estilos inline
    $newContent = $newContent -replace 'radial-gradient\(circle at top right, #E28C8C 0%, #C74E4E 100%\)', 'radial-gradient(circle at top right, #C74E4E 0%, #540202 100%)'
    
    if ($newContent -ne $content) {
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated colors in $($file.Name)"
    }
}
