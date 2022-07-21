       
# create a shared network
docker network create localnet

# Expose engines and setup shared path for migrations
docker run -p 1433:1433  --volume shared:/shared:z --name mssql1
 --hostname mssql1 --network localnet -d dbatools/sqlinstance
docker run -p 14333:1433 --volume shared:/shared:z --name mssql
 --hostname mssql2 --network localnet -d dbatools/sqlinstance2

        ###########
        
docker ps

        ###########
        
Connect-DbaInstance -SqlInstance localhost -SqlCredential sqladmin

# Connect to SQL Server in a container listening on non standard port
$cred = Get-Credential sqladmin
Connect-DbaInstance -SqlInstance localhost:14333 -SqlCredential $cred

        ###########
        
New-DbaClientAlias -ServerName localhost -Alias mssql1
Connect-DbaInstance -SqlInstance mssql1 -SqlCredential sqladmin


        ###########
        