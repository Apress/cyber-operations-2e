# PowerShell script to set the home folder to a per-user file share for all users on a domain.

Import-Module ActiveDirectory
$users = Get-ADUser -Filter *
foreach ($user in $users){
   $baseshare = '\\Ala\UserData'
   $homeshare = $baseshare + '\' + $user.SamAccountName
   New-Item $homeshare -type directory

   $Acl = Get-ACL $baseshare  # Use parent as base for ACL list
   $Ar = New-Object system.security.accesscontrol.filesystemaccessrule(   `
                    $user.SamAccountName,"FullControl","ContainerInherit, `
                    ObjectInherit","None","Allow") 
   $Acl.SetAccessRule($Ar)
   Set-Acl $homeshare $Acl

   Set-ADUser $user -HomeDrive 'H' -HomeDirectory $homeshare
}
