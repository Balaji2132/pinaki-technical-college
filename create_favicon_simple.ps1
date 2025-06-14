# PowerShell script to create a multi-resolution favicon.ico
Add-Type -AssemblyName System.Drawing

$logoPath = "d:\program\pinaki-technical-college\Images\logo.png"
$faviconPath = "d:\program\pinaki-technical-college\favicon.ico"

if (Test-Path $logoPath) {
    try {
        # Load the original logo
        $originalImage = [System.Drawing.Image]::FromFile($logoPath)
        
        # Create a 48x48 bitmap (most common favicon size)
        $bitmap = New-Object System.Drawing.Bitmap(48, 48)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        
        # Draw the resized image
        $graphics.DrawImage($originalImage, 0, 0, 48, 48)
        $graphics.Dispose()
        
        # Save as ICO
        $bitmap.Save($faviconPath, [System.Drawing.Imaging.ImageFormat]::Icon)
        
        # Cleanup
        $bitmap.Dispose()
        $originalImage.Dispose()
        
        Write-Host "✓ favicon.ico created successfully"
        
        # Verify the created file
        $fileInfo = Get-Item $faviconPath
        Write-Host "File size: $($fileInfo.Length) bytes"
        
    } catch {
        Write-Error "Error creating favicon: $_"
    }
} else {
    Write-Error "Logo file not found at: $logoPath"
}
