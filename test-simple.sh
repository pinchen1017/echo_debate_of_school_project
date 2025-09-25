#!/bin/bash

# 簡化版API測試腳本

echo "🧪 開始測試簡化版事實查核API..."

BASE_URL="http://localhost:3000"

# 測試健康檢查
echo "1. 測試健康檢查..."
curl -s "$BASE_URL/api/health" | jq '.' || echo "健康檢查失敗"

echo ""

# 測試特定session API
echo "2. 測試特定session API..."
RESPONSE=$(curl -s "$BASE_URL/api/session/b19e3815-6cb8-4221-a273-3818d1c9f6cc")

echo "Session API回應:"
echo "$RESPONSE" | jq '.' || echo "$RESPONSE"

echo ""
echo "3. 測試不存在的session..."
curl -s "$BASE_URL/api/session/invalid-session" | jq '.' || echo "測試不存在的session"

echo ""
echo "✅ 簡化版API測試完成！"
echo ""
echo "🌐 前端測試："
echo "1. 訪問 http://localhost 查看首頁"
echo "2. 訪問 http://localhost/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc 查看特定分析結果"
echo "3. 在事實查核頁面輸入查詢進行分析"
