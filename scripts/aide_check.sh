#!/bin/bash
/sbin/aide --check
mail -s "AIDE [Intrusion Detection] log" root@localhost < /var/log/aide/aide.log