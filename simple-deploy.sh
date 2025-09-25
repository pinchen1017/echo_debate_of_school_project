#!/bin/bash

# 簡化的事實查核系統部署腳本

set -e

echo "🚀 開始部署簡化版事實查核系統..."

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
    echo "   特定session: http://localhost/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc"
    echo "   API健康檢查: http://localhost/api/health"
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
echo ""
echo "💡 測試方法："
echo "1. 訪問 http://localhost 查看首頁"
echo "2. 訪問 http://localhost/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc 查看特定分析結果"
echo "3. 在事實查核頁面輸入查詢進行分析"
