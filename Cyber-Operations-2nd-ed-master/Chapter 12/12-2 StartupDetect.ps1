# PowerShell script that loops through all of the users and computers on a domain and then writes out the content
# of that user's startup folder on that computer.

foreach($account in Get-ADUser -Filter * ){
   $username = $account.SamAccountName
   foreach($system in Get-AdComputer -Filter *){
      $computername = $system.name
      $dir = "\\$computername\C$\Users\$username\AppData\Roaming" `
           + "\Microsoft\Windows\Start Menu\Programs\Startup"
      if(Test-Path $dir){
         ls $dir
         }
      }
   }
