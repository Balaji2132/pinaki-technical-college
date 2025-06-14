# PowerShell script to create a multi-resolution favicon.ico
# This creates a proper ICO file with multiple sizes embedded

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

function Create-MultiResolutionIcon {
    param(
        [string]$LogoPath,
        [string]$OutputPath,
        [int[]]$Sizes = @(16, 32, 48)
    )
    
    try {
        # Load the original logo
        $originalImage = [System.Drawing.Image]::FromFile($LogoPath)
        
        # Create bitmaps for each size
        $bitmaps = @()
        foreach ($size in $Sizes) {
            $bitmap = New-Object System.Drawing.Bitmap($size, $size)
            $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
            $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
            $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
            
            # Draw the resized image
            $graphics.DrawImage($originalImage, 0, 0, $size, $size)
            $graphics.Dispose()
            
            $bitmaps += $bitmap
        }
        
        # Save as ICO using the largest bitmap as primary
        $bitmaps[2].Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Icon)
        
        # Cleanup
        foreach ($bitmap in $bitmaps) {
            $bitmap.Dispose()
        }
        $originalImage.Dispose()
        
        Write-Host "Multi-resolution favicon.ico created successfully at: $OutputPath"
        
        # Verify the created file
        $fileInfo = Get-Item $OutputPath
        Write-Host "File size: $($fileInfo.Length) bytes"
        
        # Test the icon by loading it
        $testIcon = [System.Drawing.Icon]::new($OutputPath)
        Write-Host "Icon dimensions: $($testIcon.Width)x$($testIcon.Height)"
        $testIcon.Dispose()
        
    } catch {
        Write-Error "Error creating favicon: $_"
    }
}

# Create the multi-resolution favicon
$logoPath = "d:\program\pinaki-technical-college\Images\logo.png"
$faviconPath = "d:\program\pinaki-technical-college\favicon.ico"

if (Test-Path $logoPath) {
    Create-MultiResolutionIcon -LogoPath $logoPath -OutputPath $faviconPath -Sizes @(16, 32, 48)
    Write-Host "✓ Multi-resolution favicon.ico created successfully"
} else {
    Write-Error "Logo file not found at: $logoPath"
}
}
