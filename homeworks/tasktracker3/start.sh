#!/bin/bash

export PORT=5205

cd ~/www/tasktracker3
./bin/tasktracker3 stop || true
./bin/tasktracker3 start
