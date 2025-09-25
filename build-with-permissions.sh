#!/bin/bash

echo "🚀 開始構建，修復權限問題..."

# 設置錯誤時退出
set -e

# 進入前端目錄
cd echo_debate_of_school_project

echo "📦 安裝依賴..."
npm install

echo "🔧 修復 vite 權限..."
# 確保 vite 有執行權限
chmod +x node_modules/.bin/vite 2>/dev/null || true

echo "🏗️ 使用 npx 構建..."
# 使用 npx 避免權限問題
npx vite build

echo "✅ 構建完成！"

# 回到根目錄
cd ..

echo "🎉 所有步驟完成！"
