#!/bin/bash

# === CONFIGURATION ===
DOMAIN="google.com"                  
LOG_FILE="ping_log.csv"              
INTERVAL=300                         


if [ ! -f "$LOG_FILE" ]; then
    echo "Timestamp,Domain,Response_Time_ms" >> "$LOG_FILE"
fi

while true; do
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    PING_RESULT=$(ping -c 1 "$DOMAIN" | grep 'time=')

    if [[ -n "$PING_RESULT" ]]; then
        
        RESPONSE_TIME=$(echo "$PING_RESULT" | sed -n 's/.*time=\(.*\) ms/\1/p')
    else
        RESPONSE_TIME="timeout"
    fi

    echo "$TIMESTAMP,$DOMAIN,$RESPONSE_TIME" >> "$LOG_FILE"
    
    sleep $INTERVAL
done
