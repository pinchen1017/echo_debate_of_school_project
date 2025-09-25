#!/bin/bash

echo "🚀 終極構建方案 - 絕對不會失敗"

# 設置錯誤時退出
set -e

echo "📦 進入前端目錄..."
cd echo_debate_of_school_project

echo "📦 安裝依賴..."
npm install

echo "🔍 檢查 vite 文件是否存在..."
if [ -f "node_modules/vite/bin/vite.js" ]; then
    echo "✅ 找到 vite.js 文件"
else
    echo "❌ 找不到 vite.js 文件，嘗試其他方法..."
    # 備用方案：使用 npm run build
    npm run build
    exit 0
fi

echo "🏗️ 使用 Node.js 直接執行 vite..."
node node_modules/vite/bin/vite.js build

echo "✅ 構建完成！"

# 回到根目錄
cd ..

echo "🎉 終極構建成功！"
