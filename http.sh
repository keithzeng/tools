source credential.profile

display_usage() {
	echo "This script requires at least two arguments, and params and values are sent thru data"
	echo "Usage: $0 request_type url param1=value1 param2=value2 ..." 
} 

NUMARG="$#"
if [ $NUMARG -lt 2 ]; then
	display_usage
	exit 1
fi

command="curl -u $USER:$PASS -X $1 $2"

data="{"
if [ $NUMARG -ge 3 ]; then
	key="${3%%:*}"
	val="${3#*:}"
	data+="\"$key\":\"$val\""
fi
for p in "${@:4}"; do
	key="${p%%:*}"
	val="${p#*:}"
	data+=",\"$key\":\"$val\""
done
data+="}"

if [ $NUMARG -gt 2 ]; then
	command+=" -d '${data}'"
fi

echo "exectuing command: $command"
eval "$command"
