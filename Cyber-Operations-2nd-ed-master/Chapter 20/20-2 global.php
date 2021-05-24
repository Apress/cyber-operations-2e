<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
  <title>Admin Page</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<?php
$pass = $_POST["pass"];
if(!empty($pass))
	if(md5($pass)== '2b4ae288a819f2bcf8e290332c838148')
		$admin = 1;

if($admin == 1)
	administer();
else
	authenticate();

function administer()
{
echo <<<html
<h3> Welcome to the site, administrator.</h3>
html;
}

function authenticate()
{
echo <<<html
<h3>Welcome to the system</h3>
<p>Authentication is required.</p>
<form method="POST" action="{$_SERVER['PHP_SELF']}">
Password: <input type="password" name="pass">
<input type="submit">
</form>
html;
}
?>

</body>
</html>
