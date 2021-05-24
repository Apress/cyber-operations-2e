# PowerShell script to parse the Sysmon Operational log and examine the data from a 
#  process creation event by casting the data as XML.

$events = Get-WinEvent -FilterHashTable @{logname='Microsoft-Windows-Sysmon/Operational'; id=1}

foreach($event in $events) {
  
   $eventXML = [xml]$event.ToXml()

   $image = $eventXML.Event.EventData.Data | where {$_.name -eq "Image"}
   $commandline = $eventXML.Event.EventData.Data | 
        where {$_.name -eq "CommandLine"}
   $user = $eventXML.Event.EventData.Data | where {$_.name -eq "User"}
   $integritylevel = $eventXML.Event.EventData.Data | 
        where {$_.name -eq "IntegrityLevel"}
   $eventpid = $eventXML.Event.EventData.Data | 
        where {$_.name -eq "ProcessID"}
   $eventppid = $eventXML.Event.EventData.Data | 
        where {$_.name -eq "ParentProcessID"}
   $parent = $eventXML.Event.EventData.Data | 
        where {$_.name -eq "ParentImage"}

   $image, $commandline, $user, $integritylevel, $eventpid, $eventppid, $parent

   ""
}


