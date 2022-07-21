$config = Import-PowerShellDataFile -Path .\Config\Config.psd1        


$pw = (Get-Credential wejustneedthepassword).Password
New-DbaLogin -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Password $pw -Login WWI_ReadOnly

New-DbaLogin -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Password $pw -Login WWI_ReadWrite

New-DbaLogin -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Password $pw -Login WWI_Owner

# Create database users
New-DbaDbUser -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Login WWI_ReadOnly -Database WideWorldImporters -Confirm:$false

New-DbaDbUser -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Login WWI_ReadWrite -Database WideWorldImporters -Confirm:$false

New-DbaDbUser -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Login WWI_Owner -Database WideWorldImporters -Confirm:$false

# Add database role members
Add-DbaDbRoleMember -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Database WideWorldImporters -User WWI_Readonly -Role db_datareader

Add-DbaDbRoleMember -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Database WideWorldImporters -User WWI_ReadWrite -Role db_datawriter

Add-DbaDbRoleMember -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Database WideWorldImporters -User WWI_Owner -Role db_owner

# Create some SQL Server Agent jobs
$job = New-DbaAgentJob -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Job 'dbatools lab job' -Description 'Creating a test job for our lab'

New-DbaAgentJobStep -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Job $Job.Name -StepName 'Step 1: Select statement' -Subsystem TransactSQL -Command 'Select 1'

# add second job
$job = New-DbaAgentJob -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Job 'dbatools lab - where am I' -Description 'Creating test2 job for our lab'

New-DbaAgentJobStep -SqlInstance "$($config.ComputerName)\$($config.SqlNamedInstance)" -Job $Job.Name -StepName 'Step 1: Select servername' -Subsystem TransactSQL -Command 'Select @@ServerName'
