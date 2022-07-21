# Read in our configuration file - any values to be changed are in here.
$config = Import-PowerShellDataFile -Path .\Config\Config.psd1

Connect-DbaInstance -SqlInstance $config.ComputerName

Find-DbaInstance -ComputerName localhost