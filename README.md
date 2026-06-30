# SQL-Server-Info README

## Purpose

- This script collects a broad set of SQL Server instance and current-database diagnostic and configuration values and returns them as a two-column result set (ItemKey, ItemValue).

## What it captures

- Connection context: connection transport, protocol, authentication scheme, local and client addresses/ports and physical net transport.
- Server-level properties: many `SERVERPROPERTY()` values (*Edition, EngineEdition, Collation, MachineName, ProductVersion/ProductBuild/ProductLevel, InstanceName, default paths, feature flags such as IsHadrEnabled, IsFullTextInstalled, IsPolyBaseInstalled, IsXTPSupported, Filestream configuration, etc*.).
- Interpreted server properties: the script maps numeric codes to readable text for fields like *EditionID, EngineEdition, FilestreamConfiguredLevel, HadrManagerStatus, ProductBuildType, ProductLevel*, and other flags so output is human-friendly.
- Database-level metadata: current database name, compatibility level (mapped to SQL Server version names), and recovery model.
- Memory configuration: min and max server memory configuration values and current in-use values (formatted with thousands separators and "MBytes" unit).
- Version string: @@VERSION output is included.

## Result format

- The script builds a derived table (dvdtable) by UNION-ing many single-row SELECTs that produce ItemKey and ItemValue columns, and finally selects from that table to produce a vertical key/value list.
- Example rows (representative): ItemKey = '\#Version', ItemValue = 'Microsoft SQL Server 2019 ...'; ItemKey = 'ServerProperty.Edition', ItemValue = 'Developer' (or other edition).

## How it works (technical summary)

- Uses `SERVERPROPERTY()`, `DB_NAME()`, `@@VERSION`, `CONNECTIONPROPERTY()`, and `sys.*` views (`sys.databases`, `sys.configurations`) to collect server and database state.
- Uses `CASE` statements to convert numeric codes into descriptive strings for readability.
- Uses `FORMAT()` and `TRY_CAST()` to present memory values with thousand separators and MBytes unit.
- The script is written entirely as a single `SELECT` from a derived table constructed by many `UNION` and `SELECT` statements, which makes it easy to add or remove keys.

## How to run

- Recommended: run from SQL Server Management Studio (SSMS) or via `sqlcmd/Invoke-Sqlcmd` while connected to the target instance and with an appropriate database selected.
- Example using PowerShell (commented in the script):
    - Download raw SQL from repo and run with `Invoke-Sqlcmd`:
        - The script contains a commented example showing how to fetch and execute it from a raw GitHub URL with `Invoke-WebRequest` and `Invoke-Sqlcmd`.
- Minimal privileges required: `CONNECT` to the instance and `VIEW SERVER STATE / VIEW SERVER STATE` or membership in server roles may be needed for some `SERVERPROPERTY/sys.*` calls; run with an account that can read the requested metadata.

## Output consumption suggestions

- For automation, export the result as CSV or JSON and ingest into configuration management or inventory systems. The key/value layout is simple to pivot into columns if desired.
- For monitoring: run regularly (via agent or scheduled task) and compare outputs across time or across instances for drift detection (e.g., edition changes, build updates, memory configuration changes).

## Common use cases

- Quick inventory of SQL Server instance properties for documentation or onboarding.
- Pre-audit checks before upgrades (confirm ProductVersion/ProductLevel, Edition, features like In-Memory OLTP support).
- Troubleshooting connection details and local/net addresses used by the current session.

## Security and operational notes

- The script emits server metadata (machine name, server name, process id) that may be sensitive in some environments — avoid storing output in public places.
- Running remotely: ensure transport security (TLS) when executing over the network and restrict who can run and read results.

## Invoking by PowerShell

`$url = "https://raw.githubusercontent.com/umsgpa/SQL-Server-Info/main/SQL%20Server%20Info.sql"`

`$sql = Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty Content`

`Invoke-Sqlcmd -ServerInstance "<SQLServer>\<SQLServerInstance>" -Database "<database_name>" -Query $sql`



## License and attribution

- Add your license (MIT/Apache2) according to project policy and include a short NOTE stating this script queries instance metadata and should be run by authorized DBAs only.



⁂


