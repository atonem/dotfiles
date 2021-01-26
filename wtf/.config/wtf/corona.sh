#!/bin/bash

if [ $1 = "deaths" ]; then
  curl -s -L covid19.trackercli.com/history/$2/deaths | ghead -n -16
elif [ $1 = "cases" ]; then
  curl -s -L covid19.trackercli.com/history/$2/cases | ghead -n -16
else
  curl -s -L covid19.trackercli.com/$1 | ghead -n -10
fi
