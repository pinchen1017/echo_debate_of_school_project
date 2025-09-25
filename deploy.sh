#!/bin/bash

echo "🚀 開始終極穩定部署..."

# 設置錯誤時退出
set -e

echo "📦 安裝前端依賴..."
cd echo_debate_of_school_project
npm install

echo "🏗️ 構建前端..."
npm run build

echo "✅ 前端構建完成！"

# 回到根目錄
cd ..

echo "📦 安裝後端依賴..."
cd server
npm install

echo "✅ 後端依賴安裝完成！"

# 回到根目錄
cd ..

echo "🎉 所有準備工作完成！"
echo "現在可以啟動服務器了..."