# PowerShell to search for WMI FilterToConsumer bindings across a domain

foreach($system in Get-AdComputer -Filter *){
  $computername = $system.name
  Get-WmiObject -Namespace root\subscription `
                -Class __FilterToConsumerBinding `
                -ComputerName $computername | Format-List -Property Path
}
