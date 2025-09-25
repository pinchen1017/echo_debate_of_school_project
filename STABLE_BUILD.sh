#!/bin/bash

echo "🚀 穩定構建方案 - 適應 Render 環境"

# 設置錯誤時退出
set -e

echo "📦 進入前端目錄..."
cd echo_debate_of_school_project

echo "📦 安裝依賴..."
npm install

echo "🔍 檢查 vite 是否可用..."
if command -v vite &> /dev/null; then
    echo "✅ vite 命令可用"
    vite build
elif [ -f "node_modules/.bin/vite" ]; then
    echo "✅ 找到 vite 可執行文件"
    ./node_modules/.bin/vite build
else
    echo "✅ 使用 npm run build"
    npm run build
fi

echo "✅ 構建完成！"

# 回到根目錄
cd ..

echo "🎉 穩定構建成功！"
