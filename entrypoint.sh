#!/bin/bash -i
set -e

. ${HOME}/.bashrc

WORKDIR=${SRCDIR:-/src}

cd $WORKDIR

if [[ "$PYPI_URL" != "https://pypi.python.org/" ]] || \
   [[ "$PYPI_INDEX_URL" != "https://pypi.python.org/simple" ]]; then
    pip config set global.index "$PYPI_URL"
    pip config set global.index-url "$PYPI_INDEX_URL"
fi

pip config list

if [ -f requirements.txt ]; then
    pip install --user -r requirements.txt
fi # [ -f requirements.txt ]

echo "$@"

if [[ "$@" == "" ]]; then
    pyinstaller --clean -y --dist ./dist/linux --workpath /tmp *.spec
    chown -R --reference=. ./dist/linux
else
    sh -c "$@"
fi # [[ "$@" == "" ]]
