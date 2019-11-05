#!/bin/bash

cat -| sed 's/</\&lt;/g;s/>/\&gt;/g' | pandoc -f markdown -t html

echo "<br/><br/><a href="../tree">View Code</a>"
