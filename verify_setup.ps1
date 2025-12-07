# Neovim Setup Verification Script for Windows
# This script checks if all prerequisites are installed and working

# Colors for output
$Red = 'Red'
$Green = 'Green'
$Yellow = 'Yellow'
$Blue = 'Cyan'

# Counters
$script:Passed = 0
$script:Failed = 0
$script:Warnings = 0

# Print colored message
function Write-ColorMessage {
    param(
        [string]$Color,
        [string]$Message
    )
    Write-Host $Message -ForegroundColor $Color
}

# Check if command exists
function Test-Command {
    param(
        [string]$Command,
        [string]$Name,
        [bool]$Required
    )
    
    $cmd = Get-Command $Command -ErrorAction SilentlyContinue
    if ($cmd) {
        try {
            $version = & $Command --version 2>&1 | Select-Object -First 1
            Write-ColorMessage $Green "✓ $Name found: $version"
            $script:Passed++
            return $true
        } catch {
            Write-ColorMessage $Green "✓ $Name found"
            $script:Passed++
            return $true
        }
    } else {
        if ($Required) {
            Write-ColorMessage $Red "✗ $Name not found (REQUIRED)"
            $script:Failed++
        } else {
            Write-ColorMessage $Yellow "⚠ $Name not found (optional)"
            $script:Warnings++
        }
        return $false
    }
}

Write-ColorMessage $Blue "=============================================="
Write-ColorMessage $Blue "  Neovim Setup Verification (Windows)"
Write-ColorMessage $Blue "=============================================="
Write-Host ""

Write-ColorMessage $Blue "Detected OS: Windows $([System.Environment]::OSVersion.Version.Major).$([System.Environment]::OSVersion.Version.Minor)"
Write-Host ""

Write-ColorMessage $Blue "Checking required tools..."
Write-Host ""

# Check required tools
Test-Command "nvim" "Neovim" $true
Test-Command "git" "Git" $true

Write-Host ""
Write-ColorMessage $Blue "Checking optional tools for full setup..."
Write-Host ""

Test-Command "node" "Node.js" $false
Test-Command "npm" "NPM" $false
Test-Command "python" "Python" $false
Test-Command "rg" "ripgrep" $false

Write-Host ""
Write-ColorMessage $Blue "Checking C/C++ development tools..."
Write-Host ""

$gccFound = Test-Command "gcc" "GCC" $false
if (-not $gccFound) {
    Test-Command "clang" "Clang" $false
}
Test-Command "cmake" "CMake" $false
Test-Command "gdb" "GDB" $false

Write-Host ""
Write-ColorMessage $Blue "Checking Scoop package manager..."
Write-Host ""

if (Test-Command "scoop" "Scoop" $false) {
    Write-ColorMessage $Green "  Scoop is available for package management"
} else {
    Write-ColorMessage $Yellow "  Scoop not found. Consider installing for easier package management:"
    Write-Host "  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
    Write-Host "  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"
}

Write-Host ""
Write-ColorMessage $Blue "Checking configuration..."
Write-Host ""

# Check if config exists
$configPath = "$env:LOCALAPPDATA\nvim"
if (Test-Path $configPath) {
    Write-ColorMessage $Green "✓ Neovim config directory exists: $configPath"
    $script:Passed++
    
    # Check if init.lua exists
    $initLua = Join-Path $configPath "init.lua"
    if (Test-Path $initLua) {
        Write-ColorMessage $Green "✓ init.lua found"
        $script:Passed++
    } else {
        Write-ColorMessage $Red "✗ init.lua not found"
        $script:Failed++
    }
    
    # Check setup type
    $minimalMarker = Join-Path $configPath ".minimal_setup"
    if (Test-Path $minimalMarker) {
        Write-ColorMessage $Blue "  Setup type: MINIMAL"
    } else {
        Write-ColorMessage $Blue "  Setup type: FULL"
    }
} else {
    Write-ColorMessage $Yellow "⚠ Neovim config directory not found at $configPath"
    Write-ColorMessage $Yellow "  Run the installer first: .\install.ps1"
    $script:Warnings++
}

Write-Host ""
Write-ColorMessage $Blue "=============================================="
Write-ColorMessage $Blue "  Verification Summary"
Write-ColorMessage $Blue "=============================================="
Write-Host ""

Write-ColorMessage $Green "Passed: $Passed"
Write-ColorMessage $Yellow "Warnings: $Warnings"
Write-ColorMessage $Red "Failed: $Failed"

Write-Host ""

if ($Failed -gt 0) {
    Write-ColorMessage $Red "Some required tools are missing!"
    Write-Host ""
    Write-ColorMessage $Yellow "Install missing tools using Scoop:"
    Write-Host ""
    Write-ColorMessage $Yellow "  scoop install neovim git nodejs python ripgrep"
    Write-Host ""
    Write-ColorMessage $Yellow "For C/C++ development (optional):"
    Write-ColorMessage $Yellow "  scoop install mingw cmake llvm"
    Write-Host ""
    exit 1
} elseif ($Warnings -gt 0) {
    Write-ColorMessage $Yellow "Setup is functional but some optional tools are missing."
    Write-ColorMessage $Yellow "Install them for full functionality (see above)."
    exit 0
} else {
    Write-ColorMessage $Green "All checks passed! Your setup is ready."
    Write-ColorMessage $Green "Start Neovim with: nvim"
    exit 0
}
