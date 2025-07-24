#!/bin/bash

#get time
TIME=$(/bin/date '+%Y-%m-%d %H:%M:%S')

#list of services
SERVICES=(apache2 ssh firewalld NetworkManager snapd systemd-resolved rsyslog)

#log file path
LOG_FILE="/home/wajith/projects/service-uptime-monitor/logs/service-monitor.log"

if [ ! -f "$LOG_FILE" ] 
then
        touch "$LOG_FILE"
fi

for service in "${SERVICES[@]}"
do
        if systemctl is-active --quiet "$service"
        then
                continue
        else
                echo "$service is down at $TIME" >> "$LOG_FILE"
                systemctl start "$service"
        fi
done
