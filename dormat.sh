#!/bin/bash

tmux \
  rename-window nvim \; \
  new-window -n exec \; \
  new-window -n config \; \
  new-window -n top -- "btop" \; \
  new-window -n ranger -- "ranger" \; \
  new-window -n music -- "kew" \; \
  select-window -t nvim
