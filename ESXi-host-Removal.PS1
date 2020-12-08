 # This script is use to remove bunch of ESXi hosts (bulk in one shot) when they are in maintenance mode in vCenter.
 
 $vCenter = Read-Host "Enter the vCenter IP or FQDN"
 $vCenter # Double checking the hostname

 $userid = Read-Host "Enter the domain name\domainId"
 $userid
 $passwd = Read-Host "Enter the domain password"
 $passwd

 $ConnectingvCenter = Connect-VIServer $vCenter -User $userid -Password $passwd
 
 Write-Host "$ConnectingvCenter is successfully connected" -ForegroundColor red -BackgroundColor Yellow

 Start-Sleep -Seconds 2 #Just a break
  
 Write-Host "Script is about to start the actual task" -ForegroundColor Red -BackgroundColor Black

 $vmhosts = Get-Content 'C:\Temp\servers' # Is a variable file to store the input, we pass.

 $maintenance = Get-VMHost $vmhosts | Ft Name, ConnectionState

 $maintenance #Double checking, these host status

 Start-Sleep -Seconds 2

foreach ($vmhost in $vmhosts) {

Write-Host " confirming that these hosts are in maintenance mode" -ForegroundColor red 
} 
start-sleep -Seconds 3  #Just a break to proceed with next steps

Remove-VMHost $vmhosts -Confirm:$false #Removing ESXi host one after another.

Start-Sleep -Seconds 2 

Write-Host "All said hosts in the CR got removed from vCenter inventory" -ForegroundColor Red -BackgroundColor Black

#Disconnect VIServer session of an user (which is a good practice)

Disconnect-VIServer -Confirm:$false
