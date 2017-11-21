#!/bin/bash

/bin/mkdir -p /var/log/logs_archive/`date '+%Y'-'%m'`
/bin/rm -f /var/log/logrotate
/bin/ln -s /var/log/logs_archive/`date '+%Y'-'%m'` /var/log/logrotate
