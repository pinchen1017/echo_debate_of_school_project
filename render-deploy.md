# Render.com 部署指南

## 優點
- 免費方案可用
- 自動部署
- 自動SSL證書
- 簡單易用

## 部署步驟

### 1. 準備項目
確保您的項目結構如下：
```
UI4/
├── echo_debate_of_school_project/    # 前端
├── server/                          # 後端
├── session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json
├── Dockerfile
├── docker-compose.yml
└── nginx.conf
```

### 2. 創建 Render 帳戶
1. 訪問 https://render.com
2. 註冊帳戶（可使用GitHub登入）

### 3. 連接 GitHub
1. 將您的代碼推送到 GitHub 倉庫
2. 在 Render 中連接您的 GitHub 帳戶

### 4. 創建 Web Service
1. 點擊 "New +" → "Web Service"
2. 選擇您的 GitHub 倉庫
3. 配置設置：
   - **Name**: fact-check-system
   - **Environment**: Docker
   - **Region**: 選擇離您最近的區域
   - **Branch**: main
   - **Root Directory**: 留空（使用根目錄）
   - **Dockerfile Path**: Dockerfile
   - **Docker Context**: 留空

### 5. 環境變數設置
在 Render 的 Environment Variables 中添加：
```
NODE_ENV=production
PORT=3000
```

### 6. 部署
1. 點擊 "Create Web Service"
2. Render 會自動構建和部署您的應用
3. 等待部署完成（通常需要 5-10 分鐘）

### 7. 獲取域名
部署完成後，您會得到一個類似這樣的域名：
```
https://fact-check-system.onrender.com
```

### 8. 測試
訪問以下URL測試：
- 首頁: https://your-app-name.onrender.com
- 特定session: https://your-app-name.onrender.com/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc

## 注意事項
- 免費方案在無活動時會休眠，首次訪問可能需要等待幾秒鐘
- 免費方案有使用限制，如需更高性能可升級到付費方案
