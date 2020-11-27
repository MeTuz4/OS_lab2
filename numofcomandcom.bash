#!/bin/bash

ps -F U user | grep -c user | awk '{print $1}'> file
ps a U user o user,pid,command | grep user | awk '{print $2 ":" $3}' >> file
