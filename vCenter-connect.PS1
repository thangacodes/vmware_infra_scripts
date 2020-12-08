# This PowerCLI script is use to connect any Users, who is authenticate to login vCenter and disconnect the session as well.

$vCenter = Read-Host "Enter the vCenter server name or IP address"

$credential = Get-Credential -UserName domain\domainId -Message "Enter the password"

$vCenterlogin = Connect-VIServer -Server $vCenter -Credential $credential

if($vCenterlogin.IsConnected -eq 'True')
{
Write-Host "Login is succeed" -ForegroundColor Red -BackgroundColor Yellow
}

elseif($vCenterlogin.IsConnected -ne 'False') {

Write-Host "Login is not succeed" -ForegroundColor Red -BackgroundColor Yellow
}

Start-Sleep -Seconds 2
Disconnect-VIServer -Confirm:$false 
Write-Host "disconnected the vC $vCenter" -ForegroundColor Red -BackgroundColor Black
