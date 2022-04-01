#!/bin/bash

# cd to script dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

now=`date`
echo "Starting: $now"

if [ -f running ]; then
	echo "$0 still running"
	exit 1
fi

touch running
trap "rm $PWD/running" EXIT

#TARGET=${1:-full}
TARGET=${1:-html}

# throw away building artefacts
git stash
git stash drop
# get latest version
git pull

# only languages which have translations in transifex
: ${langs:=en cs de es fr hu it ja ko li nl pt_BR pt_PT ro ru zh-Hans}

# if you only want to build one language, do:
# $ langs=de ./docker-world.sh

for l in $langs
  do
    ./docker-run.sh $TARGET LANG=$l
    build_ok=$?
    if [[ "$build_ok" = "0" ]]; then
      echo "Build OK: syncing to web"
      # 20220317 sync to remote www2
      time rsync -hvrzc --delete --progress build/html/$l www2.qgis.org:/var/www/qgisdata/QGIS-Documentation-3.22/live/html
#      time rsync -hvrzc --delete --progress build/pdf www2.qgis.org:/var/www/qgisdata/QGIS-Documentation-3.22/live/html
#      time rsync -hvrzc --delete --progress build/zip www2.qgis.org:/var/www/qgisdata/QGIS-Documentation-3.22/live/html
    else
      echo "Build FAILED: not syncing to web";
    fi
  done

now=`date`
echo "Finished: $now"
