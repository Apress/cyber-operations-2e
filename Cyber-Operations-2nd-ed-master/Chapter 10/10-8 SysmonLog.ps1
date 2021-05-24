# PowerShell script to parse the Sysmon Operational log and examine the structure of an entry,
#  by casting the data as XML.

$events = Get-WinEvent -FilterHashTable @{logname='Microsoft-Windows-Sysmon/Operational'; id =1}

foreach($event in $events) {

   $eventXML = [xml]$event.ToXml()

   for($i=0; $i -le 20; $i++){
      $eventXML.Event.EventData.Data[$i]
   }
   ""
} 
