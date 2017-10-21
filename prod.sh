#!/bin/bash

cp "$(dirname ${0})/git-watcher.service" /etc/systemd/system/git-watcher.service
systemctl daemon-reload
systemctl enable git-watcher.service
systemctl restart git-watcher.service
