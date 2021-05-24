<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
  <title>Product Information</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<?php
if(!isset($_GET['Customer']))
{
echo <<<html
<body>
<h1>Welcome to Acme Coyote and Road Runner Supply Company.</h1>
<p>Before we can proceed, we need you to log in.</p>
<form action="{$_SERVER['PHP_SELF']}" method="GET">
<input type="radio" name="Customer" value="include_coyote">Wile E. Coyote<br>
<input type="radio" name="Customer" value="include_roadrunner">Road Runner<br>
<input type="submit" value="Log On">
</form>
</body>
html;
}

else
include($_GET['Customer'].".php");
?>
</html>
