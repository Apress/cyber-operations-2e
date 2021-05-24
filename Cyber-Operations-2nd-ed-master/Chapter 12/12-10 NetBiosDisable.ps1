# PowerShell script to disable NetBIOS over TCP/IP on every adapter with an IP address on every system in a domain.

foreach($system in Get-AdComputer -Filter *){
  $computername = $system.name
  $computername

  $adapters = Get-WmiObject -Computer $computername `
                             Win32_NetworkAdapterConfiguration
  foreach ($adapter in $adapters){
    if($adapter.IPAddress -ne $null){
      $adapter.SetTcpipNetbios(2)
      }
    }
  }
