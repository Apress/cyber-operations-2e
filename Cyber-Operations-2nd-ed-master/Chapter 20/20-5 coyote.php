<?php

$bg_color = '#000000';
$fg_color = '#ff0000';
$Customer = "Wile E. Coyote";

echo <<<html
<body bgcolor="$bg_color" text="$fg_color">
<h1>Acme Coyote and Road Runner Supply Company</h1>
<p>Thank you for visiting us today Mr. Wile E. Coyote!</p>
<p>Would you care to place an order?</p>
<form action="include_order.php" method="POST">
<input type="checkbox" value="Rocket" name="item[]">Rocket<br />
<input type="checkbox" value="Giant Rubber Band" name="item[]">Giant Rubber Band<br />
<input type="checkbox" value="Dynamite" name="item[]">Dynamite<br />
<input type="submit" value="Place Order">
</form>
</body>
html;
?>
