#!/usr/bin/env bash
cat test.tmux | perl -pnle "s/(|)\s//ge" | perl -pnle "s/#\[.*\](|)//ge"
