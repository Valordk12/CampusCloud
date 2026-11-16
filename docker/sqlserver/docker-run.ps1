docker run `
-d `
--env-file "$PSScriptRoot\.env" `
--network campus-network `
--name sqlserver-campuscloud `
-p 1435:1433 `
-v campscloud-sql-data:/var/opt/mssql `
--restart always `
mcr.microsoft.com/mssql/server:2025-latest

# docker run `
# -d `
# --env-file "$PSScriptRoot\.env" `
# --name sqlserver-campuscloud `
# -p 1435:1433 `
# -v campscloud-sql-data:/var/opt/mssql `
# --restart always `
# mcr.microsoft.com/mssql/server:2025-latest