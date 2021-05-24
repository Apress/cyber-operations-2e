# PowerShell script that reads a list of users from a file, parses out the first name(s) and the last name,
#  then creates a new Active Directory user with that name on the domain corp.saturn.test and the password
#  "password1!"


$nameslist = Get-Content C:\Users\Administrator\Desktop\Users.txt
ForEach ($name in $nameslist) {
  $first = $name.Split(' ')[0]
  $last = $name.Split(' ')[-1]
  $username = $first.ToLower()[0] + $last.ToLower()

  New-ADUser -Name $name `
   -AccountPassword (
          ConvertTo-SecureString “password1!” -AsPlainText -Force) `
   -DisplayName $name `
   -Enabled $true `
   -SamAccountName $username `
   -givenname $first `
   -surname $last `
   -userprincipalname ($username + “@corp.saturn.test”) `
  }
