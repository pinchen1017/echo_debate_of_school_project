# 事實查核系統 (Fact Check System)

一個基於多代理模型的事實查核平台，支援LINE整合和網頁分析功能。

## 🚀 快速開始

### 本地開發

1. **啟動後端服務**
```bash
cd server
npm install
npm start
```

2. **啟動前端服務**
```bash
cd echo_debate_of_school_project
npm install
npm run dev
```

3. **訪問應用**
- 前端: http://localhost:5173
- 後端API: http://localhost:3000

### 雲端部署

使用Docker一鍵部署：

```bash
# 設置環境變數
cp env.example .env
# 編輯.env檔案設置必要的變數

# 執行部署腳本
chmod +x deploy.sh
./deploy.sh
```

或使用Docker Compose：

```bash
docker-compose up -d --build
```

## 📋 功能特性

### 1. LINE整合
- 支援透過URL參數`?session_id=<uuid>`直接載入分析結果
- 自動切換到事實查核頁面並顯示分析內容

### 2. 事實查核分析
- 整合Cofact API進行初步查證
- 使用多代理模型進行深度分析
- 提供LLM、SLM和法庭辯論系統三種分析視角

### 3. 實時分析
- 支援實時分析結果展示
- 提供進度追蹤和狀態更新

### 4. 響應式設計
- 適配桌面和移動設備
- 現代化的用戶界面

## 🔧 API文檔

### 開始分析

**端點**: `POST /api/analyze`

**請求格式**:
```json
{
    "app_name": "judge",
    "user_id": "user",
    "session_id": "616",
    "new_message": {
        "role": "user",
        "parts": [{"text": "柯文哲是總統"}]
    }
}
```

**回應格式**:
```json
{
    "run_id": "616",
    "quick_verdict": {
        "label": "不確定",
        "score_true": 0.52,
        "reason": "正在收集證據"
    },
    "deep_link": "http://your-domain.com/?session_id=616"
}
```

### 獲取分析結果

**端點**: `GET /api/session/{session_id}`

**回應格式**:
```json
{
    "status": "done",
    "progress": 1,
    "overview": {
        "verdict": "假消息",
        "score_true": 0.18,
        "last_updated": "2024-01-15T10:30:00.000Z"
    },
    "analysisResult": {
        "weight_calculation_json": { ... },
        "final_report_json": { ... },
        "fact_check_result_json": { ... },
        "classification_json": { ... }
    }
}
```

## 🏗️ 系統架構

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   LINE Bot      │    │   Web Frontend  │    │   API Backend   │
│                 │    │                 │    │                 │
│ 發送session_id  │───▶│ 自動載入分析    │───▶│ 處理分析請求    │
│ 到網站URL       │    │ 結果並顯示      │    │ 並返回結果      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │                        │
                                ▼                        ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │   Nginx         │    │   Cofact API    │
                       │   (反向代理)    │    │   (事實查核)    │
                       └─────────────────┘    └─────────────────┘
```

## 📁 項目結構

```
UI4/
├── echo_debate_of_school_project/    # 前端React應用
│   ├── src/
│   │   ├── components/               # React組件
│   │   ├── css/                     # 樣式文件
│   │   ├── assets/                  # 靜態資源
│   │   └── ...
│   ├── package.json
│   └── vite.config.js
├── server/                          # 後端Node.js API
│   ├── index.js                     # 主服務器文件
│   ├── package.json
│   └── ...
├── Dockerfile                       # Docker配置
├── docker-compose.yml              # Docker Compose配置
├── nginx.conf                      # Nginx配置
├── deploy.sh                       # 部署腳本
├── env.example                     # 環境變數範例
└── DEPLOYMENT.md                   # 詳細部署指南
```

## 🔐 環境變數

| 變數名 | 描述 | 必需 |
|--------|------|------|
| `JWT_SECRET` | JWT密鑰 | ✅ |
| `VITE_COFACT_TOKEN` | Cofact API令牌 | ✅ |
| `NODE_ENV` | 運行環境 | ❌ |
| `PORT` | 後端端口 | ❌ |

## 🚀 部署到雲端

### AWS
- 使用ECS或EC2部署Docker容器
- 配置Application Load Balancer
- 設置Route 53域名解析

### Google Cloud
- 使用Cloud Run部署容器
- 配置Cloud Load Balancing
- 設置Cloud DNS

### Azure
- 使用Container Instances或App Service
- 配置Application Gateway
- 設置Azure DNS

詳細部署指南請參考 [DEPLOYMENT.md](./DEPLOYMENT.md)

## 🛠️ 開發指南

### 添加新的分析模型

1. 在後端`index.js`中添加新的分析邏輯
2. 更新`fullAnalysis()`函數返回新的數據結構
3. 在前端`fact_check.jsx`中添加對應的UI組件

### 自定義UI主題

1. 修改`echo_debate_of_school_project/src/css/`中的CSS文件
2. 更新組件中的樣式類名
3. 重新構建前端應用

## 📊 監控和日誌

- 使用`docker-compose logs -f`查看實時日誌
- 訪問`/health`端點進行健康檢查
- 監控API響應時間和錯誤率

## 🤝 貢獻指南

1. Fork項目
2. 創建功能分支
3. 提交更改
4. 發起Pull Request

## 📄 許可證

本項目採用MIT許可證 - 查看 [LICENSE](LICENSE) 文件了解詳情

## 📞 支持

如有問題或建議，請：
- 提交Issue
- 聯繫開發團隊
- 查看項目文檔

---

**注意**: 部署到生產環境前，請確保：
- 設置強密碼作為JWT_SECRET
- 配置適當的CORS策略
- 啟用HTTPS加密
- 設置適當的防火牆規則