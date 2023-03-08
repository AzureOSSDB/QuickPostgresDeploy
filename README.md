# Quick Postgres Deploy
This Solution provides a bash script and Bicep template to automatically and quickly provision and deploy a sample database to Azure Postgres Flexible Server.

Few things to note:

- This solution is intended purely for testing purposes and is not intended for production use.
- This solution deploys a sample, publically available DVD Rental database
- There is a public firewall with open IP access to connect to the database, this is not best practice and should be changed to a private endpoint or a private IP address should you use this beyond quick testing.

## Instructions
- From a bash prompt run the ./deploy.sh script
- You will be prompted for the database name (has to be globally unique), and the admin password (the admin user is 'postgres')