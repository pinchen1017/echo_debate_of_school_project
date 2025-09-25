#!/bin/bash

# API測試腳本

echo "🧪 開始測試事實查核API..."

BASE_URL="http://localhost:3000"

# 測試健康檢查
echo "1. 測試健康檢查..."
curl -s "$BASE_URL/api/health" | jq '.' || echo "健康檢查失敗"

echo ""

# 測試分析API
echo "2. 測試分析API..."
RESPONSE=$(curl -s -X POST "$BASE_URL/api/analyze" \
  -H "Content-Type: application/json" \
  -d '{
    "app_name": "judge",
    "user_id": "user",
    "session_id": "test-616",
    "new_message": {
      "role": "user",
      "parts": [{"text": "柯文哲是總統"}]
    }
  }')

echo "分析請求回應:"
echo "$RESPONSE" | jq '.' || echo "$RESPONSE"

# 提取session_id
SESSION_ID=$(echo "$RESPONSE" | jq -r '.run_id' 2>/dev/null || echo "test-616")

echo ""
echo "3. 等待分析完成..."
sleep 6

# 測試獲取分析結果
echo "4. 測試獲取分析結果..."
curl -s "$BASE_URL/api/session/$SESSION_ID" | jq '.' || echo "獲取分析結果失敗"

echo ""
echo "✅ API測試完成！"
