#!/bin/bash

# export SA_PASSWORD=''

# Check if the SA_PASSWORD environment variable is set
if [ -z "$SA_PASSWORD" ]; then
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

sudo docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=$SA_PASSWORD" \
-p 1433:1433 --name mssqlserver -v /home/avelis/sql_database:/var/opt/mssql \
-d mcr.microsoft.com/mssql/server:2022-latest

# Show running containers
sudo docker ps

# Allow SQL Server port on the firewall
sudo ufw allow 1433/tcp
