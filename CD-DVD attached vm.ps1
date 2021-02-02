### This is the simple VMware PowerCLI to fetch out the vm's which are attached/connected ISO in it from a Datastore.

$VMs = Get-Content C:\Users\thangadurai\Music\vm-list.txt
$Output = foreach ($VM in $VMs){
Get-CDDrive $VM | select Parent, IsoPath
}
$Output | Export-Csv C:\temp\Results.csv -NoTypeInformation

###### To make it a simple one-liner ######
$VMs = Get-VM | Get-CDDrive | select Parent, IsoPath

### Other way to find out ####
Get-VM | Get-CDDrive | Select-Object Parent, IsoPath | Where-Object { $_.IsoPath -ne $null }
