#!/bin/bash -i
set -e

. ${HOME}/.bashrc

WORKDIR=${SRCDIR:-/src}

cd $WORKDIR

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
