<?php

$bg_color = '#000000';
$fg_color = '#fff000';
$Customer = "Road Runner";

echo <<<html
<body bgcolor="$bg_color" text="$fg_color">
<h1>Acme Coyote and Road Runner Supply Company</h1>
<p>Thank you for visiting us today Road Runner!</p>
<p>Would you care to place an order?</p>
<form action="include_order.php" method="POST">
<input type="checkbox" value="Bird Seed" name="item[]">Bird Seed<br />
<input type="checkbox" value="Water" name="item[]">Water<br />
<input type="submit" value="Place Order">
</form>
</body>
html;
?>
