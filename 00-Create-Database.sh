mkdir ~/sql_database
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io
sudo systemctl enable --now docker  # Enables and starts Docker in one step
docker --version
sudo docker pull mcr.microsoft.com/mssql/server:2022-latest
sudo docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourStrongPassword123" \
-p 1433:1433 --name mssqlserver -v /home/avelis/sql_database:/var/opt/mssql \
-d mcr.microsoft.com/mssql/server:2022-latest
docker ps
sudo ufw allow 1433/tcp
