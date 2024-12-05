#!/bin/bash

PROCESS_NAME="process-monitor"
MONITORING_URL="http://127.0.0.1:1333/health"
LOG_FILE="/var/log/monitoring.log"
SERVICE_NAME="process-monitor.service"
PID_FILE="./$PROCESS_NAME.pid"

get_pid() {
    pgrep -x "$PROCESS_NAME"
}

if [[ -f "$PID_FILE" ]]; then
    prev_pid=$(cat "$PID_FILE")
else
    prev_pid=""
fi

while true; do
    current_pid=$(get_pid)

    if [[ -n "$current_pid" && "$current_pid" != "$prev_pid" ]]; then
        echo "$(date) - Service $PROCESS_NAME has been restarted. New PID: $current_pid" >> $LOG_FILE
        echo "$current_pid" > "$PID_FILE" 
        prev_pid="$current_pid" 
    fi

    if [[ -n "$current_pid" ]]; then
        RESPONSE=$(curl --write-out "%{http_code}" --silent --output /dev/null "$MONITORING_URL")

        if [[ "$RESPONSE" -eq 200 ]]; then
            echo "$(date) - Monitoring server responded successfully. Response code: $RESPONSE" >> $LOG_FILE
        else
            echo "$(date) - Failed to connect to monitoring server. Response code: $RESPONSE" >> $LOG_FILE
        fi
    fi

    sleep 60
done
