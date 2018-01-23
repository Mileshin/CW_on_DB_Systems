#!/bin/sh

while : ; do
      node main.js
         [ $? != 0 ] && break
done
