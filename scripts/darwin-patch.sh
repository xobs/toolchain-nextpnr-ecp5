#!/bin/bash -x
prog_name="$1"
if [ -z $prog_name ]
then
	echo "Usage $0 [target_name]"
	exit 1
fi

otool -L "$prog_name" | while read i
do
	if ! echo $i | grep -q "@rpath"
	then
		echo "Skipping [$i]"
		continue
	fi
	base_lib=$(echo "$i" | awk '{print $1}')
	new_path=$(echo "$base_lib" | sed 's|@rpath|/tmp/nextpnr/lib|')
	install_name_tool -change "$base_lib" "$new_path" "$prog_name"
done
