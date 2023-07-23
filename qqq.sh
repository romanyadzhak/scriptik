#!/bin/bash

echo "$(perl -E 'say "=" x 80')"

#ID_list=$(awk -F: '{print $3 ":" $1}' /etc/passwd)
echo "$(grep -E 1[0-9]{3} /etc/passwd | awk -F: '{print $3 ":" $1}')"











echo "$(perl -E 'say "=" x 80')"
