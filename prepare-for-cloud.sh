#!/bin/bash

# 雲端部署準備腳本

echo "🚀 準備事實查核系統進行雲端部署..."

# 檢查必要文件
echo "📋 檢查必要文件..."
required_files=(
    "Dockerfile"
    "docker-compose.yml"
    "nginx.conf"
    "server/index.js"
    "session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json"
    "echo_debate_of_school_project/package.json"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file 存在"
    else
        echo "❌ $file 不存在"
        exit 1
    fi
done

# 檢查前端是否已構建
echo "🔨 檢查前端構建..."
if [ ! -d "echo_debate_of_school_project/dist" ]; then
    echo "📦 構建前端..."
    cd echo_debate_of_school_project
    npm install
    npm run build
    cd ..
else
    echo "✅ 前端已構建"
fi

# 檢查後端依賴
echo "📦 檢查後端依賴..."
cd server
if [ ! -d "node_modules" ]; then
    echo "📦 安裝後端依賴..."
    npm install
else
    echo "✅ 後端依賴已安裝"
fi
cd ..

# 創建部署包
echo "📦 創建部署包..."
tar -czf fact-check-system.tar.gz \
    Dockerfile \
    docker-compose.yml \
    nginx.conf \
    start.sh \
    server/ \
    echo_debate_of_school_project/dist/ \
    session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json

echo "✅ 部署包已創建: fact-check-system.tar.gz"
echo ""
echo "🌐 部署選項："
echo "1. Render.com (推薦): 查看 render-deploy.md"
echo "2. AWS EC2: 查看 aws-deploy.md"
echo "3. Google Cloud: 查看 gcp-deploy.md"
echo ""
echo "📋 部署包內容："
echo "- Dockerfile: Docker 配置"
echo "- docker-compose.yml: 容器編排"
echo "- nginx.conf: 反向代理配置"
echo "- server/: 後端代碼"
echo "- echo_debate_of_school_project/dist/: 前端構建文件"
echo "- session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json: 靜態數據"
echo ""
echo "🎉 準備完成！現在可以選擇任一雲端平台進行部署。"
