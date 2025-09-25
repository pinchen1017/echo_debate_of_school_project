#!/bin/sh

# 啟動後端服務
cd /app/backend
npm start &

# 等待後端服務啟動
sleep 5

# 啟動nginx
nginx -g "daemon off;"
