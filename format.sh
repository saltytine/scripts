#!/bin/bash

tmux \; \
  split-window -h -l 80 -- 'btop' \; \
  split-window -v -l 20 -- 'kew' \; \
  select-pane -L \; \
  split-window -v -l 20 -- 'ranger' \; \
  select-pane -U \; \
  attach

