<html>
	<head>
		<title>Cgit Portal</title>
		<style>
			.clonelinkhelp {
				display:none;
				position: relative;
			}
			.clonelink:hover .clonelinkhelp {
				border:1px solid #000000;
				display:block;
				position:absolute;
				background-color: #cccccc;
				z-index:0;
			}
		</style>
	</head>
	<body>
		<form method="POST">
			<input type="text" name="searchtext" style="width:300px;" />
			<input type="submit" value="Search Repos"/>
			<input type="hidden" name="search" value="yes" />
			<input type="button" value="Reset" onClick="location.href='CGITURL';" />
		</form>
		<table>
<?php
if (strcmp($_POST['search'],"yes")==0) {
?>
			<tr>
				<th>Repository</th>
				<th>File</th>
			</tr>
	<?php
	$links = explode("\n",shell_exec("grep -R '" . $_POST['searchtext'] . "' GITPATH/* | grep -v '/\.git/' | awk 'BEGIN { FS=\":\" } { print $1 }' | sort | uniq"));
	foreach ($links as $thisLink) {
		$escapePath = str_replace("/","\\/","GITPATH");
		$newFile = preg_replace('/^' . $escapePath . '\/(.*)$/','/$1',$thisLink);
		$repoName = preg_replace('/^\/([a-zA-Z0-9_-]+).*$/','$1',$newFile);
		$newLink = preg_replace('/^\/([a-zA-Z0-9_-]+)\/(.*)$/','CGITURL$1/.git/tree/$2',$newFile);
		?>
			<tr>
				<td>
					<a href="CGITURL<?php echo "$repoName"; ?>/.git/about"><?php echo "$repoName"; ?></a>
				</td>
				<td>
					<a href="<?php echo "$newLink"; ?>"><?php echo "$newFile"; ?></a>
				</td>
			</tr>
		<?php
	}
}
else {
	?>
			<tr>
				<th>Repositories</th>
				<th></th>
				<th></th>
			</tr>
	<?php
	$fileContents = array_unique(preg_grep("/^\/git.*\.git\//",explode("'",file_get_contents("CGITURL"))));
foreach ($fileContents as $thisLine) {
	$repoURL = str_replace("'","",$thisLine);
	$repoAboutURL = $repoURL . "about/";
	$repoTreeURL = $repoURL . "tree/";
	$repoName = str_replace("/git/","",str_replace("/.git/","",$thisLine));
?>
			<tr>
				<td>
					<a href="<?php echo "$repoAboutURL"; ?>"><?php echo "$repoName"; ?></a>
				</td>
				<td>
					<a href="<?php echo "$repoTreeURL"; ?>">Code</a>
				</td>
				<td>
					<div class="clonelink"><a onClick="return false;" href="<?php echo "$repoURL"; ?>">Clone</a><span class="clonelinkhelp">Right-click and copy clone link</span></div>
				</td>
			</tr>
<?php
}
}
?>
		</table>
	</body>
</html>
