
select dvdtable.ItemKey, dvdtable.ItemValue from (

select N'#Version' as ItemKey, @@VERSION as ItemValue UNION
select N'#DatabaseName' as ItemKey, DB_NAME() as ItemValue UNION
select N'ConnectionProperty.net_transport' as ItemKey, CONNECTIONPROPERTY('net_transport') as ItemValue UNION
select N'ConnectionProperty.protocol_type' as ItemKey, CONNECTIONPROPERTY('protocol_type') as ItemValue UNION
select N'ConnectionProperty.auth_scheme' as ItemKey, CONNECTIONPROPERTY('auth_scheme') as ItemValue UNION
select N'ConnectionProperty.local_net_address' as ItemKey, CONNECTIONPROPERTY('local_net_address') as ItemValue UNION
select N'ConnectionProperty.local_tcp_port' as ItemKey, CONNECTIONPROPERTY('local_tcp_port') as ItemValue UNION
select N'ConnectionProperty.client_net_address' as ItemKey, CONNECTIONPROPERTY('client_net_address') as ItemValue UNION
select N'ConnectionProperty.physical_net_transport' as ItemKey, CONNECTIONPROPERTY('physical_net_transport') as ItemValue UNION


select N'ServerProperty.BuildClrVersion' AS ItemKey, SERVERPROPERTY('BuildClrVersion') AS ItemValue UNION
select N'ServerProperty.Collation' AS ItemKey, SERVERPROPERTY('Collation') AS ItemValue UNION
select N'ServerProperty.CollationID' AS ItemKey, SERVERPROPERTY('CollationID') AS ItemValue UNION
select N'ServerProperty.ComparisonStyle' AS ItemKey, SERVERPROPERTY('ComparisonStyle') AS ItemValue UNION
select N'ServerProperty.ComputerNamePhysicalNetBIOS' AS ItemKey, SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS ItemValue UNION
select N'ServerProperty.Edition' AS ItemKey, SERVERPROPERTY('Edition') AS ItemValue UNION

select N'ServerProperty.EditionID' AS ItemKey, case SERVERPROPERTY('EditionID') 
when 1804890536		then N'Enterprise'
when 1872460670		then N'Enterprise Edition: Core-based Licensing'
when 610778273		then N'Enterprise Evaluation'
when 284895786		then N'Business Intelligence'
when -2117995310	then N'Developer'
when -1592396055	then N'Express'
when -133711905		then N'Express with Advanced Services'
when -1534726760	then N'Standard'
when 1293598313		then N'Web'
when 1674378470		then N'SQL Database or Azure Synapse Analytics'
when -1461570097	then N'Azure SQL Edge Developer'
when 1994083197		then N'Azure SQL Edge'
else SERVERPROPERTY('EditionID')  end AS ItemValue UNION

select N'ServerProperty.EngineEdition' AS ItemKey, 

	case SERVERPROPERTY('EngineEdition') 
		when  1 then N'Personal or Desktop Engine (Not available in SQL Server 2005 (9.x) and later versions.)'
		when  2 then N'Standard (For Standard, Web, and Business Intelligence.)'
		when  3 then N'Enterprise (For Evaluation, Developer, and Enterprise editions.)'
		when  4 then N'Express (For Express, Express with Tools, and Express with Advanced Services)'
		when  5 then N'SQL Database'
		when  6 then N'Azure Synapse Analytics'
		when  8 then N'Azure SQL Managed Instance'
		when  9 then N'Azure SQL Edge (For all editions of Azure SQL Edge)'
		when 11 then N'Azure Synapse serverless SQL pool'
	else SERVERPROPERTY('EngineEdition')  
	end AS ItemValue UNION



select N'ServerProperty.FilestreamConfiguredLevel' AS ItemKey, 
	
	case SERVERPROPERTY('FilestreamConfiguredLevel') 
		when 0 then N'FILESTREAM is disabled'
		when 1 then N'FILESTREAM is enabled for Transact-SQL access'
		when 2 then N'FILESTREAM is enabled for Transact-SQL and local Win32 streaming acces'
		when 3 then N'FILESTREAM is enabled for Transact-SQL and both local and remote Win32 streaming access'
	else SERVERPROPERTY('FilestreamConfiguredLevel') 
	end
	
	AS ItemValue UNION

select N'ServerProperty.FilestreamEffectiveLevel' AS ItemKey, 
	
	case SERVERPROPERTY('FilestreamEffectiveLevel')
		when 0 then N'FILESTREAM is disabled'
		when 1 then N'FILESTREAM is enabled for Transact-SQL access'
		when 2 then N'FILESTREAM is enabled for Transact-SQL and local Win32 streaming acces'
		when 3 then N'FILESTREAM is enabled for Transact-SQL and both local and remote Win32 streaming access'
	else SERVERPROPERTY('FilestreamEffectiveLevel')
	end
	
	AS ItemValue UNION


select N'ServerProperty.FilestreamShareName' AS ItemKey, SERVERPROPERTY('FilestreamShareName') AS ItemValue UNION

select N'ServerProperty.HadrManagerStatus' AS ItemKey, 

	case isnull(SERVERPROPERTY('HadrManagerStatus'), -17101973) 
		when 0 then N'Not started, pending communication.'
		when 1 then N'Started and running.'
		when 2 then N'Not started and failed.'
		when -17101973 then N'Input isn''t valid, an error, or not applicable.'
	else SERVERPROPERTY('HadrManagerStatus') 
	end
	AS ItemValue UNION



select N'ServerProperty.InstanceDefaultBackupPath' AS ItemKey, SERVERPROPERTY('InstanceDefaultBackupPath') AS ItemValue UNION
select N'ServerProperty.InstanceDefaultDataPath' AS ItemKey, SERVERPROPERTY('InstanceDefaultDataPath') AS ItemValue UNION
select N'ServerProperty.InstanceDefaultLogPath' AS ItemKey, SERVERPROPERTY('InstanceDefaultLogPath') AS ItemValue UNION

select N'ServerProperty.InstanceName' AS ItemKey,  isnull(SERVERPROPERTY('InstanceName'), N'Input isn''t valid, an error, or not applicable.' ) AS ItemValue UNION



select N'ServerProperty.IsAdvancedAnalyticsInstalled' AS ItemKey, 
	case SERVERPROPERTY('IsBigDataCluster') 
		when 0 then N'Advanced Analytics wasn''t installed.'
		when 1 then N'Advanced Analytics feature was installed.'
	else SERVERPROPERTY('IsAdvancedAnalyticsInstalled') 
	end
	AS ItemValue UNION

select N'ServerProperty.IsBigDataCluster' AS ItemKey, 
	case SERVERPROPERTY('IsBigDataCluster') 
		when 0 then N'The instance isn''t SQL Server Big Data Cluster.'
		when 1 then N'The instance is SQL Server Big Data Cluster.'
	else SERVERPROPERTY('IsBigDataCluster') 
	end
	AS ItemValue UNION

select N'ServerProperty.IsClustered' AS ItemKey, 

	case isnull(SERVERPROPERTY('IsClustered'), -17101973)
		when 0 then N'Clustered.'
		when 1 then N'Not Clustered.'
		when -17101973 then N'Input isn''t valid, an error, or not applicable.'
	else SERVERPROPERTY('IsClustered')
	end
	AS ItemValue UNION


select N'ServerProperty.IsExternalAuthenticationOnly' AS ItemKey, 

	case SERVERPROPERTY('IsExternalAuthenticationOnly') 
		when 0 then N'Azure AD-only authentication is disabled.'
		when 1 then N'Azure AD-only authentication is enabled.'
	else SERVERPROPERTY('IsExternalAuthenticationOnly') 
	end
	AS ItemValue UNION



select N'ServerProperty.IsExternalGovernanceEnabled' AS ItemKey, 
	case SERVERPROPERTY('IsExternalGovernanceEnabled')
		when 0 then N'External governance is disabled.'
		when 1 then N'External governance is enabled.'
	else SERVERPROPERTY('IsExternalGovernanceEnabled')
	end
	AS ItemValue UNION



select N'ServerProperty.IsFullTextInstalled' AS ItemKey, 

	case SERVERPROPERTY('IsFullTextInstalled')
		when 0 then N'Full-text and semantic indexing components aren''t installed.'
		when 1 then N'Full-text and semantic indexing components are installed.'
		when -17101973 then N'Input isn''t valid, an error, or not applicable.'
	else SERVERPROPERTY('IsFullTextInstalled')
	end
	AS ItemValue UNION



select N'ServerProperty.IsHadrEnabled' AS ItemKey, 

	case SERVERPROPERTY('IsHadrEnabled') 
		when 0 then N'The Always On availability groups feature is disabled.'
		when 1 then N'The Always On availability groups feature is enabled.'
		when -17101973 then N'Input isn''t valid, an error, or not applicable.'
	else SERVERPROPERTY('IsHadrEnabled')
	end
	AS ItemValue UNION




select N'ServerProperty.IsIntegratedSecurityOnly' AS ItemKey, 
	case SERVERPROPERTY('IsIntegratedSecurityOnly') 
		when 0 then N'Not integrated security. (Both Windows Authentication and SQL Server Authentication.)'
		when 1 then N'Integrated security (Windows Authentication)'
		when -17101973 then N'Input isn''t valid, an error, or not applicable.'
	else SERVERPROPERTY('IsIntegratedSecurityOnly')
	end
	AS ItemValue UNION

select N'ServerProperty.IsLocalDB' AS ItemKey, isnull(SERVERPROPERTY('IsLocalDB'), N'Input isn''t valid, an error, or not applicable.') AS ItemValue UNION


select N'ServerProperty.IsPolyBaseInstalled' AS ItemKey, SERVERPROPERTY('IsPolyBaseInstalled') AS ItemValue UNION


select N'ServerProperty.IsServerSuspendedForSnapshotBackup' AS ItemKey, 
	case SERVERPROPERTY('IsServerSuspendedForSnapshotBackup')
		when 0 then N'Not suspended.'
		when 1 then N'Suspended.'
	else SERVERPROPERTY('IsServerSuspendedForSnapshotBackup')
	end
	AS ItemValue UNION


select N'ServerProperty.IsSingleUser' AS ItemKey, 
	case SERVERPROPERTY('IsSingleUser') 
		when 0 then N'Not single user.'
		when 1 then N'Single user.'
		when -17101973 then N'Input isn''t valid, an error, or not applicable.'
	else SERVERPROPERTY('IsSingleUser')
	end
	AS ItemValue UNION



select N'ServerProperty.IsTempDbMetadataMemoryOptimized' AS ItemKey, 
	case SERVERPROPERTY('IsTempDbMetadataMemoryOptimized') 
		when 0 then N'if tempdb is using regular, disk-based tables for metadata. For more information, see tempdb Database.'
		when 1 then N'if tempdb has been enabled to use memory-optimized tables for metadata.'
	else SERVERPROPERTY('IsTempDbMetadataMemoryOptimized')
	end
	AS ItemValue UNION



select N'ServerProperty.IsXTPSupported' AS ItemKey, 
	case SERVERPROPERTY('IsXTPSupported') 
		when 0 then N'Server doesn''t supports In-Memory OLTP.'
		when 1 then N'Server supports In-Memory OLTP.'
		when -17101973 then N'Input isn''t valid, an error, or not applicable.'
	else SERVERPROPERTY('IsXTPSupported')
	end
	AS ItemValue UNION



select N'ServerProperty.LCID' AS ItemKey, SERVERPROPERTY('LCID') AS ItemValue UNION
select N'ServerProperty.LicenseType' AS ItemKey, SERVERPROPERTY('LicenseType') AS ItemValue UNION
select N'ServerProperty.MachineName' AS ItemKey, isnull(SERVERPROPERTY('MachineName'), N'Input isn''t valid, an error, or not applicable.') AS ItemValue UNION
select N'ServerProperty.NumLicenses' AS ItemKey, SERVERPROPERTY('NumLicenses') AS ItemValue UNION
select N'ServerProperty.PathSeparator' AS ItemKey, SERVERPROPERTY('PathSeparator') AS ItemValue UNION
select N'ServerProperty.ProcessID' AS ItemKey, isnull(SERVERPROPERTY('ProcessID'), N'Input isn''t valid, an error, or not applicable.') AS ItemValue UNION
select N'ServerProperty.ProductBuild' AS ItemKey, SERVERPROPERTY('ProductBuild') AS ItemValue UNION

select N'ServerProperty.ProductBuildType' AS ItemKey, 
	case SERVERPROPERTY('ProductBuildType') 
		when 0 then N'OD: On Demand release a specific customer.'
		when 1 then N'GDR: General Distribution Release released through Windows Update.'
		when -17101973 then N'Not applicable.'
	else SERVERPROPERTY('ProductBuildType')
	end
	AS ItemValue UNION


select N'ServerProperty.ProductLevel' AS ItemKey, 
	case when charindex('RTM', convert(nvarchar(max), SERVERPROPERTY('ProductLevel')))> 0 then N'RTM: Original release version;'
		 when charindex('SP', convert(nvarchar(max), SERVERPROPERTY('ProductLevel')))> 0 then N'SP[n]: Service Pack version;'
		 when charindex('CTP', convert(nvarchar(max), SERVERPROPERTY('ProductLevel')))> 0 then N'CTP[n]: Community Technology Preview version'
	else SERVERPROPERTY('ProductLevel')
	end
	AS ItemValue UNION
select N'ServerProperty.ProductMajorVersion' AS ItemKey, SERVERPROPERTY('ProductMajorVersion') AS ItemValue UNION
select N'ServerProperty.ProductMinorVersion' AS ItemKey, SERVERPROPERTY('ProductMinorVersion') AS ItemValue UNION
select N'ServerProperty.ProductUpdateLevel' AS ItemKey, SERVERPROPERTY('ProductUpdateLevel') AS ItemValue UNION
select N'ServerProperty.ProductUpdateReference' AS ItemKey, SERVERPROPERTY('ProductUpdateReference') AS ItemValue UNION
select N'ServerProperty.ProductVersion' AS ItemKey, SERVERPROPERTY('ProductVersion') AS ItemValue UNION
select N'ServerProperty.ResourceLastUpdateDateTime' AS ItemKey, convert(nvarchar(255), SERVERPROPERTY('ResourceLastUpdateDateTime'), 120) AS ItemValue UNION
select N'ServerProperty.ResourceVersion' AS ItemKey, SERVERPROPERTY('ResourceVersion') AS ItemValue UNION
select N'ServerProperty.ServerName' AS ItemKey, isnull(SERVERPROPERTY('ServerName'), N'Input isn''t valid, or an error.') AS ItemValue UNION
select N'ServerProperty.SqlCharSet' AS ItemKey, SERVERPROPERTY('SqlCharSet') AS ItemValue UNION
select N'ServerProperty.SqlCharSetName' AS ItemKey, SERVERPROPERTY('SqlCharSetName') AS ItemValue UNION
select N'ServerProperty.SqlSortOrder' AS ItemKey, SERVERPROPERTY('SqlSortOrder') AS ItemValue UNION
select N'ServerProperty.SqlSortOrderName' AS ItemKey, SERVERPROPERTY('SqlSortOrderName') AS ItemValue UNION
select N'ServerProperty.SuspendedDatabaseCount' AS ItemKey, SERVERPROPERTY('SuspendedDatabaseCount') AS ItemValue UNION

-------------------------------------------------------------------------------------------------
select N'Database.CompatibilityLevel' AS ItemKey, (SELECT concat( case compatibility_level
															when 80 then N'SQL Server 2000'
															when 90 then N'SQL Server 2005'
															when 100 then N'SQL Server 2008'
															when 110 then N'SQL Server 2012'
															when 120 then N'SQL Server 2014'
															when 130 then N'SQL Server 2016'
															when 140 then N'SQL Server 2017'
															when 150 then N'SQL Server 2019'
															when 160 then N'SQL Server 2022'
															when 170 then N'SQL Server 2025'
															else N'SQL Server Unknwown'
															end
															, N' ('
															, compatibility_level
															, N')'
															)  
	
														FROM sys.databases
														WHERE name = DB_NAME()
) AS ItemValue UNION

-------------------------------------------------------------------------------------------------
select N'Database.RecoveryModel' AS ItemKey, (SELECT recovery_model_desc  
	
														FROM sys.databases
														WHERE name = DB_NAME()
) AS ItemValue 

UNION

------------------------------------------------------------------------------------------------

SELECT
    case name
    when N'min server memory (MB)' then N'ServerInstance.Memory.Min'
    when N'max server memory (MB)' then N'ServerInstance.Memory.Max'
    else
    N'unknown'
    end 
    as ItemKey
    ,

    concat(N'Configured: ', format(try_cast(value as bigint), N'N0'), N' MBytes; ',N'In Use: ', format(try_cast(value_in_use as bigint), N'N0'), N' MBytes')
    as ItemValue

FROM sys.configurations
WHERE name IN ('min server memory (MB)', 'max server memory (MB)')



) dvdtable



/*


$url = "https://raw.githubusercontent.com/umsgpa/SQL-Server-Info/main/SQL%20Server%20Info.sql"

$sql = Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty Content

Invoke-Sqlcmd -ServerInstance "<SQLServer>\<SQLServerInstance>" -Database "<database_name>" -Query $sql



*/