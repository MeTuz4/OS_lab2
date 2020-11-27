#!/bin/bash
ps -A -o pid,cmd | grep '/sbin' | gawk '{print $1}' > file2
