#!/bin/bash

node-sass -w play.scss play.css &
coffee -c -w play.coffee &

wait
