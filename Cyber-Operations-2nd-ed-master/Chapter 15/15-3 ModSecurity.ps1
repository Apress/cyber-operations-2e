# PowerShell script ModSecurity.ps1 to search the Windows security log for ModSecurity alerts

$logs = Get-EventLog -LogName application -Source ModSecurity
foreach ($entry in $logs) {
   if( $entry.("Message").Contains("Access denied")){
      $entry.("Message")
   }
}
