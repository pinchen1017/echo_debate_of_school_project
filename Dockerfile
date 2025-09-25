# 簡化的 Dockerfile 用於 Render 部署
FROM node:18-alpine

WORKDIR /app

# 安裝 nginx
RUN apk add --no-cache nginx

# 複製前端構建文件（假設已經構建好）
COPY echo_debate_of_school_project/dist /usr/share/nginx/html

# 複製後端代碼
COPY server /app/server

# 複製 session 數據
COPY session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json /app/

# 複製 nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

# 複製啟動腳本
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# 安裝後端依賴
WORKDIR /app/server
RUN npm install

# 暴露端口
EXPOSE 80 3000

# 啟動服務
CMD ["/app/start.sh"]
