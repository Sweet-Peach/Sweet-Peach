#!/bin/bash
which java | grep –q /usr/bin/java 
if [ $? = 0 ]
then echo “OK”
else echo “Não OK” 
fi
