# PowerCLI script to add an ESXi host to vCenter Server.

# Edit the information, based on your environments like DEV, CERT and PROD.

# Following are the VARIABLES, which i used in this script. Please make according to your wish,

##  Specify vCenter Server
## vCenter Server username
## vCenter Server user password
## vCenter Server location which can be the Datacenter, a Folder or a Cluster.

$vCenter= Read-Host "Enter the vCenter Server name or IP address"
$vCenterUser="domain\domainId"
$vCenterUserPassword="Enter the domain password"
$vCenterlocation="Enter the vCenter Location"

# Keep the ESXi host, you want to add it to the vCenter Server and the username and password to be used.
$esxihosts=Get-Content C:\temp\hosts.txt
$esxihosts 
sleep -Seconds 1
$esxihostuser="root"
$esxihostpasswd="enter the password"  # You can keep the password in a text file and it can be converted from securestring.

## (get-credential).password | ConvertFrom-SecureString | set-content "C:\Passwords\password.txt"

#You don't have to change anything below this line.

#Connecting vCenter Server

write-host Connecting to vCenter Server $vcenter -foreground Black -BackgroundColor Cyan

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0 | out-null

write-host Start adding ESXi hosts to the vCenter Server $vCenter

#Add ESXi hosts

foreach ($esxihost in $esxihosts) {

Add-VMHost $esxihost -Location $vcenterlocation -User $esxihostuser -Password $esxihostpasswd
}

#Disconnect from vCenter Server

write-host "Disconnecting to vCenter Server $vcenter" -foreground green
disconnect-viserver -confirm:$false | out-null
