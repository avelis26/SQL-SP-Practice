#!/bin/bash

# export MSSQL_SA_PASSWORD=''

# Check if the SA_PASSWORD environment variable is set
if [ -z "$MSSQL_SA_PASSWORD" ]; then
  echo "Error: SA_PASSWORD environment variable is not set."
  exit 1
fi

# Create directory for SQL Server data
sudo chown -R 10001:0 /home/avelis/sql_database

mkdir -p ~/sql_database

# Update and install Docker
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io
sudo systemctl enable --now docker
docker --version

# Pull and run the SQL Server Docker container
sudo docker pull mcr.microsoft.com/mssql/server:2022-latest

sudo docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=$MSSQL_SA_PASSWORD" -p 1433:1433 --name mssqlserver -v /home/avelis/sql_database:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2022-latest

# Show running containers
sudo docker ps

# Allow SQL Server port on the firewall
sudo ufw allow 1433/tcp

# Restore AdventureWorks2019 database
wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak
sudo docker ps
sudo docker exec -it mssqlserver /bin/bash
mkdir -p /var/opt/mssql/backup
exit
sudo docker cp AdventureWorks2019.bak mssqlserver:/var/opt/mssql/backup/
sudo docker exec -it mssqlserver /bin/bash
# export MSSQL_SA_PASSWORD=''
/opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P "$MSSQL_SA_PASSWORD" -C
RESTORE DATABASE AdventureWorks2019
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2019.bak'
WITH MOVE 'AdventureWorks2019' TO '/var/opt/mssql/data/AdventureWorks2019.mdf',
MOVE 'AdventureWorks2019_log' TO '/var/opt/mssql/data/AdventureWorks2019.ldf';
GO
SELECT name FROM sys.databases;
GO
