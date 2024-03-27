# CDM code check script

This shell script is designed to parse your automation code for CDM API calls that are restricted on RSC managed CDM clusters. It will look for specific REST endpoints, Python methods, and PowerShell cmdlets in use in the code.

## Usage

Given a folder, this script will attempt to parse all files. It will fail if the encoding of the file is not ascii or utf-8. In this case, it is recommended you re-encode the file so that it may be parsed with this tool.

```
./cdm_code_check.sh ~/my-scripts
```

## Output

Below is an example output run against the `rubrik-scripts-for-powershell` repo. Matching patterns will indicate the file and line number that need to be investigated, as well as the matched content.

```
Warning: ~/rubrik-scripts-for-powershell/HyperV/attachments/2661974167/2661549149.png skipped due to incompatible encoding.
Warning: ~/rubrik-scripts-for-powershell/HyperV/attachments/2661974167/2661352821.xml skipped due to incompatible encoding.
Searching for pattern: /sla_domain/assign_to_downloaded_snapshots
------------------------------------
Searching for pattern: /sla_domain/
------------------------------------
Searching for pattern: unmanaged_object/assign_retention_sla
------------------------------------
Searching for pattern: /host
~/rubrik-scripts-for-powershell/RVC/Invoke-RubrikVirtualCluster.ps1:202:        "vi://${myVMwareUsername}:${myVMwarePassword}@${VMwareVCenter}/${VMwareDataCenter}/host/${VMwareCluster}"
~/rubrik-scripts-for-powershell/NAS/Set-NAS-Share-and-Fileset.ps1:114:$AddShareEndpoint = '/host/share'
------------------------------------
Searching for pattern: assign_sla
------------------------------------
Searching for pattern: create_sla
------------------------------------
Searching for pattern: delete_sla
------------------------------------
Searching for pattern: assign_physical_host_fileset
------------------------------------
Searching for pattern: New-RubrikSLA
------------------------------------
Searching for pattern: Set-RubrikSLA
------------------------------------
Searching for pattern: Remove-RubrikSLA
------------------------------------
Searching for pattern: Resume-RubrikSLA
------------------------------------
Searching for pattern: Pause-RubrikSLA
------------------------------------
Searching for pattern: Get-RubrikSLA
~/rubrik-scripts-for-powershell/Reporting/Get-Archive-Backlog.ps1:295:        $archive_slas = Get-RubrikSLA | where-object {$_.archivalSpecs -ne $null} 
~/rubrik-scripts-for-powershell/Reporting/Get-Archive-Backlog.ps1:298:            $archive_slas += Get-RubrikSLA -SLA "$getsla"
~/rubrik-scripts-for-powershell/Reporting/check_last_backup_time.ps1:9:    $sla = Get-RubrikSLA -PrimaryClusterId local -id $sla_id
~/rubrik-scripts-for-powershell/VM/protect_by_tag.ps1:59:$rubrik_sla = Get-RubrikSLA -Name $sla_domain_name | ?{$_.primaryClusterId -eq $rubrik_cluster_id}
~/rubrik-scripts-for-powershell/MV/SAP-workflow.ps1:223:$SLADataObj = Get-RubrikSLA -Name $sapDataSLA -PrimaryClusterID local
~/rubrik-scripts-for-powershell/MV/SAP-workflow.ps1:224:$SLAArchiveObj = Get-RubrikSLA -Name $sapArchiveSLA -PrimaryClusterID local
~/rubrik-scripts-for-powershell/MSSQL/set-agprotection.ps1:36:$SLAID = Get-RubrikSLA -Name $SLAName
~/rubrik-scripts-for-powershell/MSSQL/Start-RubrikOnDemandBackup.ps1:225:        $RubrikSLA = Get-RubrikSLA -Name $SLAName 
~/rubrik-scripts-for-powershell/MSSQL/multi-dc-ag-failover.ps1:95:$slaid = (Get-RubrikSLA -Name $SLAName -PrimaryClusterID local).id
~/rubrik-scripts-for-powershell/MSSQL/Deprecated/Start-RubrikDBBackup_v2.ps1:271:        $RubrikSLA = Get-RubrikSLA -Name $SLAName 
~/rubrik-scripts-for-powershell/MSSQL/Deprecated/Start-RubrikDBBackup_V1.ps1:235:                $RubrikSLA = Get-RubrikSLA -Name $SLAName 
~/rubrik-scripts-for-powershell/MSSQL/Deprecated/Start-RubrikDBLogBackup.ps1:272:        $RubrikSLA = Get-RubrikSLA -Name $SLAName 
------------------------------------
Searching for pattern: Suspend-RubrikSLA
------------------------------------
Searching for pattern: Protect-RubrikDatabase
~/rubrik-scripts-for-powershell/MSSQL/set-sql-sla.ps1:3:Get-RubrikDatabase | Where {$_.effectiveSlaDomainId -eq 'UNPROTECTED'} | Protect-RubrikDatabase -SLA Bronze -WhatIf
~/rubrik-scripts-for-powershell/MSSQL/set-sql-sla.ps1:5:Get-RubrikDatabase | Where {$_.effectiveSlaDomainId -eq 'UNPROTECTED'} | Protect-RubrikDatabase -SLA Bronze -confirm:$false
~/rubrik-scripts-for-powershell/MSSQL/set-sql-sla.ps1:7:Get-RubrikDatabase | Where {$_.effectiveSlaDomainId -eq 'UNPROTECTED'} | Protect-RubrikDatabase -SLA Bronze -confirm:$false
~/rubrik-scripts-for-powershell/MSSQL/Unprotect-DatabaseSnapshotsInRubrik.ps1:93:    Protect-RubrikDatabase -id $RubrikDatabase.id -DoNotProtect -Confirm:$false
------------------------------------
Searching for pattern: Protect-RubrikFileset
~/rubrik-scripts-for-powershell/NAS/Set-NAS-Share-and-Fileset.ps1:153:Get-RubrikFileset $Fileset -HostName $Hostname | Where-Object {$_.isRelic -ne 'True'} | Protect-RubrikFileset -SLA $SLA -Confirm:$False | Out-Null
------------------------------------
Searching for pattern: Protect-RubrikHyperVVM
------------------------------------
Searching for pattern: Protect-RubrikNutanixVM
------------------------------------
Searching for pattern: Protect-RubrikTag
------------------------------------
Searching for pattern: Protect-RubrikVApp
------------------------------------
Searching for pattern: Protect-RubrikVM
~/rubrik-scripts-for-powershell/VM/StoragePolicytoSLAv2.ps1:13:   $null = Get-RubrikVM $_.Name | Protect-RubrikVM -SLA Gold -Confirm:$false
~/rubrik-scripts-for-powershell/VM/StoragePolicytoSLAv2.ps1:18:   $null = Get-RubrikVM $_.Name | Protect-RubrikVM -SLA Silver -Confirm:$false
~/rubrik-scripts-for-powershell/VM/StoragePolicytoSLAv2.ps1:23:   $null = Get-RubrikVM $_.Name | Protect-RubrikVM -SLA Bronze -Confirm:$false
~/rubrik-scripts-for-powershell/VM/SPBMtoSLAv3.ps1:28:            $Null = Get-RubrikVM -Name $_.Name | Protect-RubrikVM -SLAID $Sla.Id -Confirm:$false
~/rubrik-scripts-for-powershell/VM/protect_by_tag.ps1:72:      #$rubrik_vm | Protect-RubrikVM -SLA $rubrik_sla -Confirm:$false
~/rubrik-scripts-for-powershell/VM/set-sla-with-csv.ps1:4:   $out = Get-RubrikVM -Name $l.VM -verbose:$false | Protect-RubrikVM -SLA $l.SLA  -verbose:$false -confirm:$false  # Optionally add -WhatIf for dry-run, or -confirm:$false to bypass confirmation questions
------------------------------------
Searching for pattern: Protect-RubrikVolumeGroup
------------------------------------
Searching for pattern: RubrikNASShare
------------------------------------
```

## Next steps

If this script discovers matches, you will need to modify your code. KB links will be provided soon to guide you on the required changes. Please do not hesitate to file a support request for any questions or concerns.