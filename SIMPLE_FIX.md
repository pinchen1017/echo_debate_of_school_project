# 🚀 最簡單的解決方案

## 問題：sh: 1: vite: Permission denied

## 解決方案（按優先級）

### 方案 1：使用 npx（最推薦）
```bash
構建命令：cd echo_debate_of_school_project && npm install && npx vite build
```

### 方案 2：使用構建腳本
```bash
構建命令：chmod +x build-with-permissions.sh && ./build-with-permissions.sh
```

### 方案 3：使用 npm run build
```bash
構建命令：cd echo_debate_of_school_project && npm install && npm run build
```

## 🎯 Render 部署配置

### 推薦設置
- **環境**：Node.js
- **Node 版本**：18.x
- **構建命令**：`cd echo_debate_of_school_project && npm install && npx vite build`
- **啟動命令**：`cd server && npm install && npm start`

## 為什麼 npx 有效？

1. **npx 會自動處理權限**：不需要手動設置執行權限
2. **npx 會找到正確的 vite**：即使路徑有問題也能正常工作
3. **npx 是 npm 的內建工具**：在 Render 環境中完全支援

## 如果 npx 還是失敗

### 備用方案：使用構建腳本
```bash
構建命令：chmod +x build-with-permissions.sh && ./build-with-permissions.sh
```

這個腳本會：
1. 安裝依賴
2. 修復權限
3. 使用 npx 構建
