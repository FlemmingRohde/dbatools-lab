<######################################
dbatools-lab - 00_Install_Prereqs.ps1
#######################################
This Install_Prereq file presumes you have internet connectivity.
If not, you'll need to download the following and copy them onto the VM
    - dbatools Powershell module
    - SQL Server Management Studio
    - Azure Data Studio
    - dbatools-lab repo
    - WideWorldImporters backup
#>

# Read in our configuration file - any values to be changed are in here.
$config = Import-PowerShellDataFile -Path .\Config\Config.psd1

## Download software, etc
    # Install the latest version of dbatools
    Install-Module dbatools

    # Install Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    # Install ADS, SSMS
    choco install ssms -y
    choco install azure-data-studio -y
    
    # Install VSCode & PowerShell Extension
    choco install vscode -y
    choco install choco install vscode-powershell -y

    # we'll use git to pull down this repo to the VM
    choco install git -y

    # download bak for WideWorldImporters
    if(!(Test-Path $config.BackupPath) {
        New-Item -Path $config.BackupPath -Type Directory
    }
    $wrSplat = @{
        uri     = 'https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak'
        OutFile = (Join-Path $config.BackupPath 'WideWorldImporters-Full.bak')
    }
    Invoke-WebRequest @wrSplat

    # download bak for AdventureWorks
    if(!(Test-Path $config.BackupPath)) {
        New-Item -Path $config.BackupPath -Type Directory
    }
    $wrSplat = @{
        uri     = 'https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak'
        OutFile = (Join-Path $config.BackupPath 'AdventureWorks2017-Full.bak')
    }
    Invoke-WebRequest @wrSplat

# Add permissions for service accounts to backup folder
# TODO