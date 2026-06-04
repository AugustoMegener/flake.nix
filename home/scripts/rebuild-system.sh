#!/bin/sh

MODE=${1:-test}

while getopts "m:" opt; do
  case "$opt" in
    m) message="$OPTARG" ;;
    *) exit 1 ;;
  esac
done

cd ~/System/

git add .
git commit -m $message
git push

sudo nixos-rebuild "$MODE" --flake ~/System#PrimaryOS

if [ $? -ne 0 ] || [ "$MODE" != "switch" ]; then
    echo -e "\n\n\033[1;33mBuilded in $MODE mode. Do not forget to run rebuild-system switch to keep changes persistently\033[0m"
fi
