#!/bin/bash

echo "<pre style=\"width:100%;white-space: pre-wrap; white-space: -moz-pre-wrap; white-space: -pre-wrap; white-space: -o-pre-wrap; word-wrap: break-word;\">"
cat - | sed "s|<|&lt;|g;s|>|&gt;|g"
echo "</pre>"
echo "<br/><br/><a href="../tree">View Code</a>"
