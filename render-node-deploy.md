# 使用 Render Node.js 環境部署（推薦）

## 🎯 為什麼選擇 Node.js 環境？
- 更簡單，不需要 Docker
- 自動處理依賴安裝
- 更少的配置錯誤

## 📋 部署步驟

### 1. 準備項目結構
確保您的項目結構如下：
```
UI4/
├── echo_debate_of_school_project/    # 前端
├── server/                          # 後端
├── session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json
└── package.json (根目錄需要)
```

### 2. 創建根目錄的 package.json
在根目錄創建 package.json：

```json
{
  "name": "fact-check-system",
  "version": "1.0.0",
  "scripts": {
    "build": "cd echo_debate_of_school_project && npm install && npm run build",
    "start": "cd server && npm install && npm start"
  },
  "engines": {
    "node": "18.x"
  }
}
```

### 3. 修改後端 package.json
確保 server/package.json 有正確的啟動腳本：

```json
{
  "name": "debate-echo-api",
  "type": "module",
  "dependencies": {
    "cors": "^2.8.5",
    "dotenv": "^16.6.1",
    "express": "^4.21.2",
    "jsonwebtoken": "^9.0.2"
  },
  "scripts": {
    "start": "node index.js"
  },
  "version": "1.0.0"
}
```

### 4. 在 Render 中創建 Web Service
1. 選擇 "Node" 環境（不是 Docker）
2. 配置設置：
   - **Build Command**: `npm run build`
   - **Start Command**: `npm start`
   - **Environment**: `Node`

### 5. 環境變數
添加以下環境變數：
```
NODE_ENV=production
PORT=3000
```

## 🔧 如果還是想用 Docker

如果您堅持使用 Docker，請使用修復後的 Dockerfile：

```bash
# 替換 Dockerfile
cp Dockerfile.fixed Dockerfile
```

## 🚀 推薦的解決方案

我建議您：
1. 使用 Node.js 環境而不是 Docker
2. 創建根目錄的 package.json
3. 在 Render 中重新創建 Web Service

這樣會更簡單且更不容易出錯。
