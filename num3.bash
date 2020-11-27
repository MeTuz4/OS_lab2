#!/bin/bash
ps -A -F | tail -n 7 | head -n 1 | tr -s " " | cut -d " " -f 2
