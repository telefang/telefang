#!/bin/bash

for i in `seq 0 44`;
do
    index=$(printf "%02x" $i);
    python rip_scripts/rip_sgb_attrfile.py extract baserom_pw.gbc versions/power/gfx/sgb/attrfile/$index.sgbattr.csv --offset=$(($i * 90 + 61144))
done

for i in `seq 0 44`;
do
    index=$(printf "%02x" $i);
    python rip_scripts/rip_sgb_attrfile.py extract baserom_sp.gbc versions/speed/gfx/sgb/attrfile/$index.sgbattr.csv --offset=$(($i * 90 + 61144))
done