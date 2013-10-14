#! /bin/bash

USERNAME="jeroendedauw"

# This part is stolen shamelessly from Antoine Musso
declare -f gerrit
 gerrit ()
 {
    if [ -z "$1" ]; then
        ARGS="--help";
    else
        ARGS="$@";
    fi;
    set -x;
    ssh -p 29418 $USERNAME@gerrit.wikimedia.org "gerrit $ARGS";
    set +x
 }

commitIds=$(gerrit query "reviewer:'self' is:open" | grep 'change I' | cut -c8-)

for commitId in $commitIds
do
	gerrit set-reviewers $commitId --remove $USERNAME
done