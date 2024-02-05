# Prepare initial output text
$outputText = @()
$separator = "============================================================="

# Retrieve GPU driver information
$outputText += "GPU Driver information (Name, DriverVersion) from WMIC:", $separator
$gpuDriverInfo = cmd.exe /c "wmic path win32_VideoController get name, driverversion"
$outputText += $gpuDriverInfo

# Output from nvidia-smi command
$outputText += "`nnvidia-smi command output:", $separator
$nvidiaSmiOutput = nvidia-smi
$outputText += $nvidiaSmiOutput

# Output from nvcc --version command
$outputText += "`nnvcc --version command output:", $separator
$nvccVersionOutput = nvcc --version
$outputText += $nvccVersionOutput

# Retrieve CUDA directory and cuDNN version information
$cudaPath = Get-ChildItem -Path "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\" | Where-Object {$_.PSIsContainer} | Sort-Object Name -Descending | Select-Object -First 1
if ($cudaPath -eq $null) {
    $outputText += "`nCUDA directory not found"
} else {
    $outputText += "`ncudnn.h and cudnn_version.h output:", $separator
    $libraryPath = Join-Path -Path $cudaPath.FullName -ChildPath "include"
    if (Test-Path $libraryPath) {
        $outputText += "CUDA Library Path Found: $libraryPath"
    } else {
        $outputText += "CUDA library directory not found"
    }
    foreach ($fileName in @("cudnn.h", "cudnn_version.h")) {
        $headerPath = Join-Path -Path $cudaPath.FullName -ChildPath "include\$fileName"
        if (Test-Path $headerPath) {
            $content = Get-Content $headerPath -Raw
            $major = [regex]::Match($content, '^\#define CUDNN_MAJOR (\d+)', 'Multiline').Groups[1].Value
            $minor = [regex]::Match($content, '^\#define CUDNN_MINOR (\d+)', 'Multiline').Groups[1].Value
            $patchlevel = [regex]::Match($content, '^\#define CUDNN_PATCHLEVEL (\d+)', 'Multiline').Groups[1].Value

            if ($major -ne "" -and $minor -ne "" -and $patchlevel -ne "") {
                $cudnnVersion = "$major.$minor.$patchlevel"
                $outputText += "CUDA Version from path: $($cudaPath.Name)`n$fileName Version: $cudnnVersion"
            } else {
                $outputText += "$fileName version information not found"
            }
        } else {
            $outputText += "$fileName not found in the CUDA include directory"
        }
    }
}

# Define the path to save the file on the desktop
$desktopPath = [System.Environment]::GetFolderPath("Desktop")
$filePath = Join-Path -Path $desktopPath -ChildPath "gpu_info.txt"

# Write final output to file on the desktop
$outputText | Out-File -FilePath $filePath

# Display results
notepad $filePath
