$config = Import-PowerShellDataFile -Path .\Config\Config.psd1  


    
Set-DbaSpConfigure -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)"-Name RemoteDacConnectionsEnabled -Value 1

Set-DbaSpConfigure -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)"-Name CostThresholdForParallelism -Value 10
