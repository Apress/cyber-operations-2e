# PowerShell script that loops through all of the users and computers on a domain and sets auditing rules on the user's
# startup directory to allow auditing for file creation. Note that this script does not handle errors, so if
# the system is down, nothing happens.

foreach($account in Get-ADUser -Filter * ){
  $username = $account.SamAccountName
  foreach($system in Get-AdComputer -Filter *){
    $computername = $system.name
    try{
      $dir = "\\$computername\C$\Users\$username\AppData\Roaming" `
           + "\Microsoft\Windows\Start Menu\Programs\Startup"
      if (-not (Test-Path –Path $dir)) {
        throw("Directory does not exist")
      }
      $directoryACL = Get-ACL $dir
      $accessrule = New-Object `
            System.Security.AccessControl.FileSystemAuditRule( `
            "Everyone","CreateFiles”, "none","none",”Success")
      $directoryACL.AddAuditRule($Accessrule)
      $directoryACL | Set-Acl $dir      
      }
    catch{
      # Failure can mean that the directory doesn't exist (perhaps that 
      #   user has not logged in!) or the target is down. 
      }
    }
  }
