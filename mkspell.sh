#!/bin/sh
find spell -name '*.add' -exec vim -c 'mkspell! -ascii {}' -c qall \;
