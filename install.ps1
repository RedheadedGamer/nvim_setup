# Neovim Configuration Installation Script for Windows
# This script installs the Neovim configuration with options for full or minimal setup

param(
    [switch]$Full,
    [switch]$Minimal,
    [switch]$Help
)

# Colors for output
$Red = 'Red'
$Green = 'Green'
$Yellow = 'Yellow'
$Blue = 'Cyan'

# Default values
$InstallType = ""
$ConfigDir = "$env:LOCALAPPDATA\nvim"
$BackupDir = "$ConfigDir.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TempCloneDir = ""

# Print colored message
function Write-ColorMessage {
    param(
        [string]$Color,
        [string]$Message
    )
    Write-Host $Message -ForegroundColor $Color
}

# Print header
function Write-Header {
    Write-Host ""
    Write-ColorMessage $Blue "================================================"
    Write-ColorMessage $Blue "  Neovim Configuration Installer (Windows)"
    Write-ColorMessage $Blue "================================================"
    Write-Host ""
}

# Show usage
function Show-Usage {
    @"
Usage: .\install.ps1 [OPTIONS]

Install Neovim configuration to $env:LOCALAPPDATA\nvim

OPTIONS:
    -Full           Install full setup with LSP, Mason, linters, and all themes
    -Minimal        Install minimal setup without LSP features and fewer themes
    -Help           Show this help message

EXAMPLES:
    .\install.ps1 -Full       # Full installation with all features
    .\install.ps1 -Minimal    # Minimal installation without LSP
    .\install.ps1             # Interactive mode (prompts for choice)

PREREQUISITES:
    - Neovim (install via: scoop install neovim)
    - Git (install via: scoop install git)
    - For full setup:
      - Node.js (install via: scoop install nodejs)
      - Python (install via: scoop install python)
      - ripgrep (install via: scoop install ripgrep)
      - GCC/Clang for C/C++ (install via: scoop install mingw or llvm)

"@
}

# Check if Scoop is installed
function Test-Scoop {
    $scoopCommand = Get-Command scoop -ErrorAction SilentlyContinue
    if (-not $scoopCommand) {
        Write-ColorMessage $Yellow "Scoop package manager not detected."
        Write-ColorMessage $Yellow "Scoop is recommended for installing prerequisites on Windows."
        Write-Host ""
        Write-ColorMessage $Blue "To install Scoop, run in PowerShell:"
        Write-Host 'Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser'
        Write-Host 'Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression'
        Write-Host ""
        $response = Read-Host "Continue without Scoop? (y/n)"
        if ($response -ne 'y' -and $response -ne 'Y') {
            exit 1
        }
    } else {
        Write-ColorMessage $Green "✓ Scoop detected"
    }
}

# Check prerequisites
function Test-Prerequisites {
    Write-ColorMessage $Blue "Checking prerequisites..."
    
    $missing = @()
    
    # Check Neovim
    $nvim = Get-Command nvim -ErrorAction SilentlyContinue
    if (-not $nvim) {
        $missing += "neovim"
        Write-ColorMessage $Red "✗ Neovim not found"
    } else {
        Write-ColorMessage $Green "✓ Neovim found: $($nvim.Version)"
    }
    
    # Check Git
    $git = Get-Command git -ErrorAction SilentlyContinue
    if (-not $git) {
        $missing += "git"
        Write-ColorMessage $Red "✗ Git not found"
    } else {
        Write-ColorMessage $Green "✓ Git found"
    }
    
    if ($InstallType -eq "full") {
        # Check Node.js
        $node = Get-Command node -ErrorAction SilentlyContinue
        if (-not $node) {
            Write-ColorMessage $Yellow "⚠ Node.js not found (required for LSP servers)"
            $missing += "nodejs"
        } else {
            Write-ColorMessage $Green "✓ Node.js found"
        }
        
        # Check Python
        $python = Get-Command python -ErrorAction SilentlyContinue
        if (-not $python) {
            Write-ColorMessage $Yellow "⚠ Python not found (required for Python LSP)"
            $missing += "python"
        } else {
            Write-ColorMessage $Green "✓ Python found"
        }
        
        # Check ripgrep
        $rg = Get-Command rg -ErrorAction SilentlyContinue
        if (-not $rg) {
            Write-ColorMessage $Yellow "⚠ ripgrep not found (optional, improves search)"
            $missing += "ripgrep"
        } else {
            Write-ColorMessage $Green "✓ ripgrep found"
        }
    }
    
    if ($missing.Count -gt 0) {
        Write-Host ""
        Write-ColorMessage $Yellow "Missing packages detected. Install with Scoop:"
        foreach ($pkg in $missing) {
            Write-Host "  scoop install $pkg"
        }
        Write-Host ""
        $response = Read-Host "Continue anyway? (y/n)"
        if ($response -ne 'y' -and $response -ne 'Y') {
            exit 1
        }
    }
}

# Parse command line arguments
function Parse-Args {
    if ($Help) {
        Show-Usage
        exit 0
    }
    
    if ($Full) {
        $script:InstallType = "full"
    } elseif ($Minimal) {
        $script:InstallType = "minimal"
    }
}

# Interactive mode to select installation type
function Select-InstallType {
    if ([string]::IsNullOrEmpty($script:InstallType)) {
        Write-Header
        Write-ColorMessage $Green "Please select installation type:"
        Write-Host ""
        Write-Host "1) Full Setup - Complete IDE experience"
        Write-ColorMessage $Yellow "   • LSP support (Language Server Protocol)"
        Write-ColorMessage $Yellow "   • Mason for LSP server management"
        Write-ColorMessage $Yellow "   • Auto-completion with nvim-cmp"
        Write-ColorMessage $Yellow "   • Linters and formatters"
        Write-ColorMessage $Yellow "   • C/C++ development tools (clangd, cmake, debugging)"
        Write-ColorMessage $Yellow "   • 50+ themes"
        Write-ColorMessage $Yellow "   • All mini.nvim plugins (28 plugins)"
        Write-Host ""
        Write-Host "2) Minimal Setup - Lightweight configuration"
        Write-ColorMessage $Yellow "   • Basic editing features"
        Write-ColorMessage $Yellow "   • Syntax highlighting with Treesitter"
        Write-ColorMessage $Yellow "   • Essential mini.nvim plugins"
        Write-ColorMessage $Yellow "   • 5 popular themes"
        Write-ColorMessage $Yellow "   • No LSP, Mason, or linters"
        Write-ColorMessage $Yellow "   • Faster startup time"
        Write-Host ""
        $choice = Read-Host "Enter your choice (1 or 2)"
        
        switch ($choice) {
            "1" { $script:InstallType = "full" }
            "2" { $script:InstallType = "minimal" }
            default {
                Write-ColorMessage $Red "Invalid choice. Exiting."
                exit 1
            }
        }
    }
}

# Backup existing configuration
function Backup-ExistingConfig {
    if (Test-Path $ConfigDir) {
        Write-ColorMessage $Yellow "Existing configuration found at $ConfigDir"
        $backupChoice = Read-Host "Do you want to backup the existing configuration? (y/n)"
        
        if ($backupChoice -eq 'y' -or $backupChoice -eq 'Y') {
            Write-ColorMessage $Blue "Backing up to $BackupDir..."
            Move-Item -Path $ConfigDir -Destination $BackupDir -Force
            Write-ColorMessage $Green "✓ Backup created successfully"
        } else {
            Write-ColorMessage $Yellow "Removing existing configuration..."
            Remove-Item -Path $ConfigDir -Recurse -Force
        }
    }
}

# Check if we're running from within the repository
function Test-RunningFromRepo {
    try {
        $gitDir = git -C $ScriptDir rev-parse --git-dir 2>$null
        if ($gitDir) {
            $repoUrl = git -C $ScriptDir config --get remote.origin.url 2>$null
            if ($repoUrl -match "nvim_setup") {
                return $true
            }
        }
    } catch {
        return $false
    }
    return $false
}

# Copy files from source to destination
function Copy-Files {
    param(
        [string]$Source,
        [string]$Destination
    )
    
    Write-ColorMessage $Blue "Copying Neovim configuration files..."
    
    if (-not (Test-Path $Destination)) {
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }
    
    # Copy all files except .git and .github
    Get-ChildItem -Path $Source -Recurse | Where-Object {
        $_.FullName -notmatch '[\\/]\.git(hub)?[\\/]' -and
        $_.Name -ne '.git' -and
        $_.Name -ne '.github'
    } | ForEach-Object {
        $targetPath = $_.FullName.Replace($Source, $Destination)
        if ($_.PSIsContainer) {
            if (-not (Test-Path $targetPath)) {
                New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
            }
        } else {
            Copy-Item -Path $_.FullName -Destination $targetPath -Force
        }
    }
    
    Write-ColorMessage $Green "✓ Files copied successfully"
}

# Clone the repository or copy files
function Install-Files {
    if (Test-RunningFromRepo) {
        Write-ColorMessage $Blue "Detected script running from repository..."
        Copy-Files -Source $ScriptDir -Destination $ConfigDir
    } else {
        Write-ColorMessage $Blue "Cloning Neovim configuration..."
        
        # Create a temporary directory for cloning
        $TempCloneDir = Join-Path $env:TEMP "nvim_install_$(Get-Random)"
        
        try {
            git clone https://github.com/RedheadedGamer/nvim_setup.git $TempCloneDir
            if ($LASTEXITCODE -ne 0) {
                throw "Git clone failed"
            }
            
            Write-ColorMessage $Green "✓ Repository cloned successfully"
            
            # Now copy files from temp directory to config directory
            Write-ColorMessage $Blue "Installing configuration files..."
            Copy-Files -Source $TempCloneDir -Destination $ConfigDir
            
            Write-ColorMessage $Green "✓ Configuration installed successfully"
        } catch {
            Write-ColorMessage $Red "✗ Failed to clone repository"
            Write-Host ""
            Write-ColorMessage $Yellow "Error: $_"
            if (Test-Path $TempCloneDir) {
                Remove-Item -Path $TempCloneDir -Recurse -Force
            }
            exit 1
        } finally {
            $script:TempCloneDir = $TempCloneDir
        }
    }
}

# Configure for minimal setup
function Set-MinimalSetup {
    Write-ColorMessage $Blue "Configuring minimal setup..."
    
    # Create a marker file to indicate minimal setup
    $markerFile = Join-Path $ConfigDir ".minimal_setup"
    New-Item -ItemType File -Path $markerFile -Force | Out-Null
    
    Write-ColorMessage $Green "✓ Minimal setup configured"
}

# Configure for full setup
function Set-FullSetup {
    Write-ColorMessage $Blue "Configuring full setup..."
    
    # Remove minimal marker if it exists
    $markerFile = Join-Path $ConfigDir ".minimal_setup"
    if (Test-Path $markerFile) {
        Remove-Item -Path $markerFile -Force
    }
    
    Write-ColorMessage $Green "✓ Full setup configured"
}

# Print post-installation instructions
function Write-Instructions {
    Write-Host ""
    Write-ColorMessage $Green "================================================"
    Write-ColorMessage $Green "  Installation Complete!"
    Write-ColorMessage $Green "================================================"
    Write-Host ""
    
    if ($InstallType -eq "full") {
        Write-ColorMessage $Blue "Next steps for FULL setup:"
        Write-Host ""
        Write-Host "1. Start Neovim:"
        Write-ColorMessage $Yellow "   nvim"
        Write-Host ""
        Write-Host "2. The configuration will automatically:"
        Write-ColorMessage $Yellow "   • Install lazy.nvim plugin manager"
        Write-ColorMessage $Yellow "   • Download and install all plugins"
        Write-ColorMessage $Yellow "   • Set up LSP servers through Mason"
        Write-Host ""
        Write-Host "3. Wait for installation to complete, then restart Neovim"
        Write-Host ""
        Write-Host "4. Install prerequisites if missing (using Scoop):"
        Write-ColorMessage $Yellow "   scoop install nodejs python ripgrep"
        Write-ColorMessage $Yellow "   scoop install mingw        # For C/C++ development"
        Write-ColorMessage $Yellow "   scoop install cmake        # For CMake projects"
        Write-Host ""
        Write-Host "5. Key bindings:"
        Write-ColorMessage $Yellow "   • <Space>ff - Find files"
        Write-ColorMessage $Yellow "   • <Space>fg - Live grep"
        Write-ColorMessage $Yellow "   • <Space>th - Theme switcher"
        Write-ColorMessage $Yellow "   • K - Hover documentation (LSP)"
        Write-ColorMessage $Yellow "   • gd - Go to definition (LSP)"
    } else {
        Write-ColorMessage $Blue "Next steps for MINIMAL setup:"
        Write-Host ""
        Write-Host "1. Start Neovim:"
        Write-ColorMessage $Yellow "   nvim"
        Write-Host ""
        Write-Host "2. The configuration will automatically:"
        Write-ColorMessage $Yellow "   • Install lazy.nvim plugin manager"
        Write-ColorMessage $Yellow "   • Download and install minimal plugins"
        Write-ColorMessage $Yellow "   • Set up basic editing features"
        Write-Host ""
        Write-Host "3. Wait for installation to complete, then restart Neovim"
        Write-Host ""
        Write-Host "4. Key bindings:"
        Write-ColorMessage $Yellow "   • <Space>e - File explorer"
        Write-ColorMessage $Yellow "   • <Space>ff - Find files"
        Write-ColorMessage $Yellow "   • <Space>th - Theme switcher"
        Write-ColorMessage $Yellow "   • gcc - Comment line"
    }
    
    Write-Host ""
    Write-Host "For more information, see:"
    Write-ColorMessage $Blue "   $ConfigDir\README.md"
    Write-Host ""
    
    if (Test-Path $BackupDir) {
        Write-ColorMessage $Yellow "Your old configuration is backed up at:"
        Write-ColorMessage $Yellow "   $BackupDir"
        Write-Host ""
    }
    
    Write-ColorMessage $Blue "Configuration location: $ConfigDir"
    Write-Host ""
}

# Clean up temporary files
function Remove-TempFiles {
    if (-not [string]::IsNullOrEmpty($script:TempCloneDir) -and (Test-Path $script:TempCloneDir)) {
        Write-ColorMessage $Blue "Cleaning up temporary files..."
        Remove-Item -Path $script:TempCloneDir -Recurse -Force
        Write-ColorMessage $Green "✓ Cleanup complete"
    }
}

# Main installation flow
function Main {
    Parse-Args
    Test-Scoop
    Select-InstallType
    Test-Prerequisites
    
    Write-Header
    Write-ColorMessage $Green "Installing $($InstallType.ToUpper()) setup to $ConfigDir"
    Write-Host ""
    
    Backup-ExistingConfig
    Install-Files
    
    if ($InstallType -eq "minimal") {
        Set-MinimalSetup
    } else {
        Set-FullSetup
    }
    
    Remove-TempFiles
    Write-Instructions
}

# Run main function
Main
