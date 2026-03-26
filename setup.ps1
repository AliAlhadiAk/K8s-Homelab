# Setup script for K8s Homelab Project

$binDir = Join-Path $PSScriptRoot "bin"
if (-not (Test-Path $binDir)) {
    New-Item -ItemType Directory -Force -Path $binDir
}

# 1. Download Terraform (Latest stable)
Write-Host "Checking Terraform..." -ForegroundColor Cyan
if (-not (Test-Path (Join-Path $binDir "terraform.exe"))) {
    Write-Host "Downloading Terraform..."
    $tfUrl = "https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_windows_amd64.zip"
    $zipPath = Join-Path $binDir "terraform.zip"
    Invoke-WebRequest -Uri $tfUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $binDir -Force
    Remove-Item $zipPath
}

# 2. Download Kind (Latest)
Write-Host "Checking Kind..." -ForegroundColor Cyan
if (-not (Test-Path (Join-Path $binDir "kind.exe"))) {
    Write-Host "Downloading Kind..."
    $kindUrl = "https://kind.sigs.k8s.io/dl/v0.22.0/kind-windows-amd64.exe"
    Invoke-WebRequest -Uri $kindUrl -OutFile (Join-Path $binDir "kind.exe")
}

# 3. Download Kubectl (Latest)
Write-Host "Checking Kubectl..." -ForegroundColor Cyan
if (-not (Test-Path (Join-Path $binDir "kubectl.exe"))) {
    Write-Host "Downloading Kubectl..."
    $kUrl = "https://dl.k8s.io/release/v1.29.0/bin/windows/amd64/kubectl.exe"
    Invoke-WebRequest -Uri $kUrl -OutFile (Join-Path $binDir "kubectl.exe")
}

# 4. Download Helm (Latest)
Write-Host "Checking Helm..." -ForegroundColor Cyan
if (-not (Test-Path (Join-Path $binDir "helm.exe"))) {
    Write-Host "Downloading Helm..."
    $helmUrl = "https://get.helm.sh/helm-v3.13.3-windows-amd64.zip"
    $zipPath = Join-Path $binDir "helm.zip"
    Invoke-WebRequest -Uri $helmUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $binDir -Force
    
    $extractedHelm = Get-ChildItem -Path $binDir -Filter "helm.exe" -Recurse | Select-Object -First 1
    if ($extractedHelm) {
        Move-Item $extractedHelm.FullName (Join-Path $binDir "helm.exe") -Force
    }

    $helmDir = Join-Path $binDir "windows-amd64"
    if (Test-Path $helmDir) {
        Remove-Item $helmDir -Recurse -Force
    }
    Remove-Item $zipPath -ErrorAction SilentlyContinue
}

Write-Host "`nSetup Complete! Add this project's /bin folder to your PATH or run scripts directly." -ForegroundColor Green
Write-Host "To use in current session: `$env:PATH += ';$binDir'" -ForegroundColor Yellow
