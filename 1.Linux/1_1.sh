#!/bin/bash
if [[ $USER == "root" ]];
    then echo "This Script is Launched by Root"
    else
      echo "This Script is Launched by `whoami`, Not Root"
fi