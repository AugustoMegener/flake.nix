#!/bin/sh

MODE=${1:-test}

cd ~/.config/nixos

git add .

sudo nixos-rebuild "$MODE" --flake ~/.config/nixos#PrimaryOS

if [ $? -eq 0 ] && [ "$MODE" = "switch" ]; then
    git commit -m "nixos rebuild: switch"
else
    echo -e "\n\n\033[1;33mBuilded in $MODE mode. Do not forget to run rebuild-system switch to keep changes persistently\033[0m"
fi
