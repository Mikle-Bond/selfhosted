# syntax=docker/dockerfile-upstream:master-labs

# inspired by https://gist.github.com/bvis/b78c1e0841cfd2437f03e20c1ee059fe
# and folks from the comments.

# Default behavior:
# variable "MY_VAR=SECRET:first" is expanded with content of `/run/secrets/first`

FROM busybox

ENTRYPOINT ["/bin/entry.sh"]
CMD [ "printenv" ]

COPY --chmod=0755 <<-"EOF" /bin/entry.sh
#!/bin/sh

# Set defaults
: "${_ENTRY_CHECK:=value}" # ( or "title" )
: "${_ENTRY_MATCHER:=SECRET:\(.\+\)$}"
: "${_ENTRY_PATH:=/run/secrets}"

  if [ "$_ENTRY_CHECK" = "value" ] ; then
	process_var=process_by_value
elif [ "$_ENTRY_CHECK" = "title" ] ; then
	process_var=process_by_title
else
	echo "$0: _ENTRY_CHECK can only be 'value' or 'title' (currently set to '$_ENTRY_CHECK')"
	exit 1
fi

set_variable() {
	target="$1"
	secret="$2"

	echo "$0: variable '$target' expands the secret '$secret'"

	export "$target"="$(cat "$_ENTRY_PATH/$secret")"
}

process_by_title() {
	title="$1"
	value="$2"

	if target=$(expr "$title" : "$_ENTRY_MATCHER") ; then
		set_variable "$target" "$value"
		unset "$title"
	fi
}

process_by_value() {
	title="$1"
	value="$2"

	if secret=$(expr "$value" : "$_ENTRY_MATCHER") ; then
		set_variable "$title" "$secret"
	fi
}

for var in $( printenv | grep -E -v '^_ENTRY_' ) ; do
	IFS="=" read -r title value <<-VAR
		$var
	VAR
	$process_var "$title" "$value"
done

unset _ENTRY_CHECK
unset _ENTRY_MATCHER
unset _ENTRY_PATH

exec "$@"

EOF

# Verification mockup
RUN <<"EOF"
	mkdir -p /run/secrets
	echo first secret >> /run/secrets/first
	echo lorem ipsum >> /run/secrets/second
	: '
	Try it:
	# docker build -t testo build/expand_secrets
	# docker run --rm -ti -e MY_VAR=SECRET:first testo
	# docker run --rm -ti `
		` -e _ENTRY_CHECK=title `
		` -e _ENTRY_MATCHER="\(.\+\)__FILE" `
		` -e _ENTRY_PATH=/ `
		` -e MY_VAR__FILE=/run/secrets/first `
		` testo
	'
EOF
