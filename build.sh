#!/bin/bash

# 設置錯誤時退出
set -e

echo "🚀 開始構建前端..."

# 進入前端目錄
cd echo_debate_of_school_project

# 安裝依賴
echo "📦 安裝依賴..."
npm install

# 檢查 vite 是否存在
if [ -f "node_modules/.bin/vite" ]; then
    echo "✅ 找到 vite 執行檔"
    chmod +x node_modules/.bin/vite
    echo "🔧 設置執行權限"
else
    echo "❌ 找不到 vite 執行檔"
    exit 1
fi

# 構建前端
echo "🏗️ 開始構建..."
node_modules/.bin/vite build

echo "✅ 前端構建完成！"

# 回到根目錄
cd ..

echo "🎉 所有構建步驟完成！"
