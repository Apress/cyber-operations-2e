# PowerShell to search for WQL queries use. The WMI Tracing Log must be enabled.

$currenttime = Get-Date
$starttime = $currenttime.AddHours(-1)

foreach($system in Get-AdComputer -Filter *){
  $computername = $system.name
 
  $events = Get-WinEvent `
    -ComputerName $computername `
    -FilterHashTable `
      @{logname='Microsoft-Windows-WMI-Activity/Trace';`
        id=11;} `
    -ErrorAction SilentlyContinue `
    -ErrorVariable ProcessError `
    -Oldest 

  if($ProcessError){
    "Error examining $computername `n (Possibly no entries)"
    continue
  }

  foreach($event in $events) {

    $eventtime = $event.TimeCreated
    if($eventtime -ge $starttime){

      $eventXML = [xml]$event.ToXml()
      $operation = $eventXML.Event.UserData.Operation_New.Operation
      $source = $eventXML.Event.UserData.Operation_New.ClientMachine
      $wmiuser = $eventXML.Event.UserData.Operation_New.User

      if($computername.ToString().ToLower() -ne $source.ToString().ToLower() ){
        "Host = $computername"
        "Time = $eventtime"
        "Command = $operation"
        "Source = $source"
        "User = $wmiuser"
        ""
        }
      }
    }
  }


