# PowerShell script IISLogAnalysis.ps1 to search IIS W3C format logs for requests blocked by a filtering 
#  rule (404.19). Be sure to adjust $log_file_name as appropriate

$log_file_name = "C:\inetpub\logs\LogFiles\W3SVC1\u_ex180422.log"

# Assumes data elements occur in the following order
$field = @{"date" = 0;
           "time" = 1;
           "s-ip" = 2; 
           "cs-method" = 3;
           "cs-uri-stem" = 4;
           "cs-uri-query" = 5;
           "s-port" = 6;
           "cs-username" = 7;
           "c-ip" = 8;
           "cs(User-Agent)" = 9;
           "cs(Referer)" = 10;
           "sc-status" = 11;
           "sc-substatus" = 12;
           "sc-win32-status" = 13;
           "time-taken" = 14}

foreach ($line in [System.IO.File]::ReadLines($log_file_name)){
   if ($line.StartsWith("#")) {
      # Nothing to do; this is a comment line.
   }
   else {
      $log = $line.split()
      if( $log[$field["sc-status"]] -eq 404) {
         if( $log[$field["sc-substatus"]] -eq 19) {
           $line  
         }
      }      
   }
}
