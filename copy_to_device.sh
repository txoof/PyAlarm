#!/bin/zsh

#attempts to copy file to attached CircuitPython device

DEST="/Volumes/CIRCUITPY/"
if [ -d ${DEST} ]
then
  cp ${1} $DEST
else
  echo "${DEST} does not appear to be mounted - is PyPortal connected?"
fi
