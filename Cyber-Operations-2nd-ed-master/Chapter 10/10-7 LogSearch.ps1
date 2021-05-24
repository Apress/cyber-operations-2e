# PowerShell script to search for security events after 3/18/2017 for the user tstafford and 
#  store the results in a file.

$start = get-date 3/18/2017
$secevents = get-eventlog -logname Security -Message "*tstafford*"
$secevents | format-list -property * | Out-File  "C:\Users\narmstrong\Desktop\results.txt"
