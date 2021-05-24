# PowerShell to search for accesses to file shares. The Audit Filtering Platform Connection must be enabled.

$connections =  New-Object System.Collections.ArrayList
$events = Get-WinEvent -FilterHashTable @{logname='Security';id=5140}

foreach($event in $events){
   $eventXML = [xml]$event.ToXML()

   $username = $eventXML.Event.EventData.Data `
          | where {$_.name -eq 'SubjectUserName'}
   $sourceIP = $eventXML.Event.EventData.Data `
          | where {$_.name -eq 'IPAddress'}
   $sharename = $eventXML.Event.EventData.Data `
          | where {$_.name -eq 'ShareName'}
   $time = $event.TimeCreated

   $connection = New-Object System.Object
   $connection | Add-Member -MemberType NoteProperty -Name "User" `
          -value $username.'#text'
   $connection | Add-Member -MemberType NoteProperty -Name "Source IP" `
          -value $sourceIP.'#text'
   $connection | Add-Member -MemberType NoteProperty -Name "ShareName" `
          -value $sharename.'#text'
   $connection | Add-Member -MemberType NoteProperty -Name "Time" `
          -value $time

   $connections.Add($connection) | Out-Null
}

$connections
