#!/bin/sh

# This is the original entrypoint, that was supposed to be fired
echo "... entrypoint: $ENTRYPOINT"
echo "... command: $@"
set -- $ENTRYPOINT "$@"
unset ENTRYPOINT

echo "... Running pre-entrypoint scripts"

for i in /docker-entrypoint.d/* ; do
	echo ".... sourcing file $i"
	. "$i"
done

echo "... All pre-scripts applied"
echo "exec $@"

exec "$@"

