#!/bin/bash

rules="$1"
shift 2
hyprctl dispatch exec "[$rules] $*"
