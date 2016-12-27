<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $language; ?>" xml:lang="<?php echo $language; ?>">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<script>
function goto(){
    window.parent.location.href="<?php echo $text_failure_url; ?>";
}
</script>
</head>
<body>
<div>
	<h1><?php echo $heading_title_failure; ?></h1>
	<p><?php echo $text_response_failure; ?></p>
	<p><?php echo $text_failure; ?></p>
	<p><?php echo $text_failure_wait; ?></p>
</div>
</body>
</html>
