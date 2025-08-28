#!/bin/bash

tmux \; \
  split-window -h -l 80 -- 'btop' \; \
  select-pane -L \; \
  split-window -v -l 20 -- 'ranger' \; \
  select-pane -U \; \
  rename-window top

