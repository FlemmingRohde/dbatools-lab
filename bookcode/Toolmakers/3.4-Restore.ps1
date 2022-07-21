# Read in our configuration file - any values to be changed are in here.
$config = Import-PowerShellDataFile -Path .\Config\Config.psd1

Restore-DbaDatabase -SqlInstance "$($config.ComputerName)\sql2017" -Path "$($config.BackupPath)\WideWorldImporters-Full.bak" -Verbose

Restore-DbaDatabase -SqlInstance "$($config.ComputerName)\sql2017" -Path "$($config.BackupPath)\AdventureWorks2017-Full.bak" -Verbose