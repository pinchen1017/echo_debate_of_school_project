@echo off
setlocal

echo 🚀 開始構建前端...

cd echo_debate_of_school_project

echo 📦 安裝依賴...
call npm install

echo 🏗️ 開始構建...
call node_modules\.bin\vite build

if %ERRORLEVEL% neq 0 (
    echo ❌ 構建失敗
    exit /b 1
)

echo ✅ 前端構建完成！

cd ..

echo 🎉 所有構建步驟完成！
