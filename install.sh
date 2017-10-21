#!/bin/bash

cp git-watcher.service /etc/systemd/system/git-watcher.service
systemctl daemon-reload
systemctl enable git-watcher.service
systemctl start git-watcher.service