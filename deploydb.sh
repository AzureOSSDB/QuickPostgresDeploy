#!/bin/bash
#az login
#az account set --subscription "Tyler Internal Microsoft Non-Prod"
#az group create --name BeckerPGAuto --location westus3
az deployment group create --resource-group BeckerPGAuto --template-file main.bicep
ls
if [ -e dvdrental.tar ]
    then
        echo "Backup File already exists"
    else
        wget https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
        sudo apt-get install unzip
        unzip ./dvdrental.zip 
fi
echo "Enter the database server name"
read servername
psql -h $servername.postgres.database.azure.com -U postgres -c 'CREATE DATABASE dvdrental'
pg_restore -h $servername.postgres.database.azure.com --dbname=dvdrental -U postgres --verbose ./dvdrental.tar