<table>
<?php
$fileContents = array_unique(preg_grep("/^\/git.*\.git\//",explode("'",file_get_contents("CGITURL"))));
foreach ($fileContents as $thisLine) {
	$repoURL = str_replace("'","",$thisLine);
	$repoAboutURL = $repoURL . "about/";
	$repoTreeURL = $repoURL . "tree/";
	$repoName = str_replace("/git/","",str_replace("/.git/","",$thisLine));
	echo "<tr><td><a href=\"$repoAboutURL\">$repoName</a></td><td><a href=\"$repoTreeURL\">Code</a></td><td><a href=\"$repoURL\">Clone</a></td></tr>"; 
}
?>
</table>
