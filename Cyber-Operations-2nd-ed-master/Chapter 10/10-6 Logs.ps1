# PowerShell script to search for account creation events in the system logs that took place after 3/8/2017

$start = get-date 3/8/2017
$secevents = get-eventlog -logname Security -Message "*A user account was created*" -after $start
$secevents | format-list -property 