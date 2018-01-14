#!/bin/bash

find . -type f -name *.csv -exec perl -pi -e 's/\r\n/\n/g' {} '+'