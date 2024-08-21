# Define the path to the shared drive (e.g., Z:\)
$drivePath = "Z:\"

# Get the list of snapshots (previous versions) for the drive
$snapshots = Get-WmiObject -Query "SELECT * FROM Win32_ShadowCopy" | Where-Object { $_.DeviceObject -like "*$drivePath*" }

# Create a custom object for each snapshot
$snapshotList = $snapshots | ForEach-Object {
    [PSCustomObject]@{
        DeviceObject = $_.DeviceObject
        VolumeName = $_.VolumeName
        ShadowCopyID = $_.ID
        InstallDate = $_.InstallDate
        Description = $_.Description
    }
}

# Export the snapshot list to a CSV file
$snapshotList | Export-Csv -Path "$env:USERPROFILE\Desktop\SnapshotsList.csv" -NoTypeInformation
