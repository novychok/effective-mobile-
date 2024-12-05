#!/bin/bash

SERVICE_FILE="/etc/systemd/system/process-monitor.service"
SERVICE_FILE_SRC="./process-monitor.service"

if [ ! -f "$SERVICE_FILE" ]; then
    echo "Creating process-monitor.service from $SERVICE_FILE_SRC"
    sudo cp "$SERVICE_FILE_SRC" "$SERVICE_FILE"
else
    echo "process-monitor.service already exists at $SERVICE_FILE"
fi

echo "Setting permissions for $SERVICE_FILE"
sudo chmod 644 "$SERVICE_FILE"

echo "Reloading systemd daemon"
sudo systemctl daemon-reload

echo "Starting process-monitor service"
sudo systemctl start process-monitor.service

echo "Enabling process-monitor service to start on boot"
sudo systemctl enable process-monitor.service

echo "Checking status of process-monitor service"
sudo systemctl status process-monitor.service
