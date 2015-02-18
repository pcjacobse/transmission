#!/bin/bash

exec /sbin/setuser nobody /usr/bin/transmission-daemon -f --config-dir=/config --logfile=/config/transmission.log

