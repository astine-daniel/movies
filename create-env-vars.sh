#!/bin/sh

if [ -z "$1" ]; then
  printf %s "Enter with API key: "
  read -r apiKey
else
  apiKey="$1"
fi

dir=$(CDPATH=" cd -- $(dirname -- "$0")" && pwd)
printf "%s\n\nexport API_KEY=%s\n" "#!/bin/sh" "$apiKey" > "$dir"/env-vars.sh
chmod +x "$dir"/env-vars.sh
