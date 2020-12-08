 
# Modify your script according to your environments like: DEV,CERT and PROD

$vCName = Read-Host "Enter the vCenter Name or IP"

Write-host about to start connecting $vCName -foreground RED -BackgroundColor Black

$credential = Get-Credential -UserName domain\domainId -Message "Enter the password"

$vCenterlogin = Connect-VIServer -Server $vCName -Credential $credential

if($vCenterlogin.IsConnected -eq 'True')
{
Write-Host "Login get succeed" -ForegroundColor Red -BackgroundColor Yellow
}

elseif($vCenterlogin.IsConnected -ne 'False') {

Write-Host "Login not succeed" -ForegroundColor Red -BackgroundColor Yellow
}

$clustername = Read-Host "Enter the clustername"

Get-Cluster $clustername | Get-VMHost | Get-VMHostNetworkAdapter | select VMhost, Name, IP, SubnetMask, Mac, PortGroupName, vMotionEnabled,mtu | Export-Csv C:\temp\$clustername.csv

Start-Sleep -Seconds 2

write-host "Disconnecting vCenter Session $vCenterServer" -foreground green -BackgroundColor Black

disconnect-viserver -confirm:$false

Write-Host "vCenter $vCName session is disconnected " -ForegroundColor Green -BackgroundColor Black
