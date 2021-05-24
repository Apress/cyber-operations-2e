# PowerShell to search for psexec use. The Audit Filtering Platform Connection must be enabled.

$connections = New-Object System.Collections.ArrayList
$events = Get-WinEvent  -FilterHashTable @{logname='Security';id=5140}

foreach($event in $events){
   $eventXML = [xml]$event.ToXML()

   $username = $eventXML.Event.EventData.Data `
          | where {$_.name -eq 'SubjectUserName'}
   $sourceIP = $eventXML.Event.EventData.Data `
          | where {$_.name -eq 'IPAddress'}
   $sharename = $eventXML.Event.EventData.Data `
          | where {$_.name -eq 'ShareName'}
   $time = $event.TimeCreated

   $starttime = [datetime]($time)  
   $endtime = [datetime]($time).AddSeconds(2)
   $commandevents = Get-WinEvent -FilterHashtable `
        @{logname="Microsoft-Windows-Sysmon/Operational";id=1;`
          StartTime=$starttime; `
          EndTime=$endtime} `
      -ErrorAction SilentlyContinue
   foreach($commandevent in $commandevents){
       $commandXML = [xml]$commandevent.ToXml()
       $parentimage = $commandXML.Event.EventData.Data `
          | where {$_.name -eq "ParentImage"}
       $image = $commandXML.Event.EventData.Data `
          | where {$_.name -eq "Image"}
       $commandtime = $commandevent.TimeCreated

       $connection = New-Object System.Object
       $connection | Add-Member -MemberType NoteProperty `
          -Name "Connection Time"  -value $time
        $connection | Add-Member -MemberType NoteProperty `
          -Name "User" -value $username.'#text'
       $connection | Add-Member -MemberType NoteProperty `
          -Name "Source IP" -value $sourceIP.'#text'
       $connection | Add-Member -MemberType NoteProperty `
          -Name "ShareName" -value $sharename.'#text'
       $connection | Add-Member -MemberType NoteProperty `
          -Name "Command Time" -value $commandtime
       $connection | Add-Member -MemberType NoteProperty `
           -Name "Parent" -value $parentimage.'#text'
       $connection | Add-Member -MemberType NoteProperty `
           -Name "Command" -value $image.'#text'

       $connections.Add($connection) | Out-Null
   }
}

$connections
