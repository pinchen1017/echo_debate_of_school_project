#!/bin/bash

# 事實查核系統快速部署腳本

set -e

echo "🚀 開始部署事實查核系統..."

# 檢查Docker是否安裝
if ! command -v docker &> /dev/null; then
    echo "❌ Docker未安裝，請先安裝Docker"
    exit 1
fi

# 檢查Docker Compose是否安裝
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose未安裝，請先安裝Docker Compose"
    exit 1
fi

# 檢查環境變數檔案
if [ ! -f .env ]; then
    echo "⚠️  .env檔案不存在，從範例檔案創建..."
    cp env.example .env
    echo "📝 請編輯.env檔案設置必要的環境變數"
    echo "   特別是JWT_SECRET和VITE_COFACT_TOKEN"
    read -p "按Enter繼續，或Ctrl+C取消..."
fi

# 停止現有容器
echo "🛑 停止現有容器..."
docker-compose down 2>/dev/null || true

# 構建並啟動服務
echo "🔨 構建並啟動服務..."
docker-compose up -d --build

# 等待服務啟動
echo "⏳ 等待服務啟動..."
sleep 10

# 檢查服務狀態
echo "🔍 檢查服務狀態..."
if docker-compose ps | grep -q "Up"; then
    echo "✅ 服務啟動成功！"
    echo ""
    echo "🌐 訪問地址："
    echo "   前端應用: http://localhost"
    echo "   API健康檢查: http://localhost/api/health"
    echo "   系統健康檢查: http://localhost/health"
    echo ""
    echo "📊 查看日誌："
    echo "   docker-compose logs -f"
    echo ""
    echo "🛑 停止服務："
    echo "   docker-compose down"
else
    echo "❌ 服務啟動失敗，請檢查日誌："
    docker-compose logs
    exit 1
fi

echo "🎉 部署完成！"
