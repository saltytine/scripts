#!/bin/bash
desktop=$1

for mon in $(bspc query -M); do
  bspc desktop -f "${desktop}@${mon}"
done

