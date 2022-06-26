#!/bin/bash

set -eo pipefail

# Make sure background processes are killed on script leave
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

html_dir=$1
ignore_src=$2

# find go mod and make sure we're using it's parent as our root.
cd "$(dirname "$(find . -name 'go.mod' | head -n 1)")" || exit 1

# clean and make our docs dir
rm -rf $html_dir
mkdir -p $html_dir

# host godoc
godoc -http=:8080 &
for (( ; ; )); do
  sleep 0.5
  if [[ $(curl -so /dev/null -w '%{http_code}' "http://localhost:8080/pkg/") -eq 200 ]]; then
    break
  fi
done

# get our html
cd $html_dir
if [ $ignore_src = 'true' ] ; then
  wget -m -k -q --reject go --show-progress --progress=dot -erobots=off --no-host-directories --no-use-server-timestamps -X /debug http://localhost:8080 || true
else
  wget -m -k -q --show-progress --progress=dot -erobots=off --no-host-directories --no-use-server-timestamps -X /debug http://localhost:8080 || true
fi

exit 0