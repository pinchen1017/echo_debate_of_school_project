# 簡化版事實查核系統

一個簡化的事實查核平台，支援透過特定session_id直接載入分析結果。

## 🚀 快速部署

### 一鍵部署

```bash
# 設置執行權限
chmod +x simple-deploy.sh

# 執行部署
./simple-deploy.sh
```

### 手動部署

```bash
# 構建並啟動
docker-compose up -d --build

# 查看狀態
docker-compose ps

# 查看日誌
docker-compose logs -f
```

## 📋 功能說明

### 1. 特定Session載入
- 支援透過URL參數 `?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc` 直接載入分析結果
- 自動切換到事實查核頁面並顯示完整分析內容

### 2. 一般事實查核
- 支援手動輸入查詢進行事實查核
- 整合Cofact API進行初步查證
- 使用本地模擬數據進行深度分析

## 🌐 訪問方式

### 本地訪問
- 前端應用: http://localhost
- 特定session: http://localhost/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc
- API健康檢查: http://localhost/api/health

### 雲端部署
將 `localhost` 替換為您的雲端服務器IP或域名即可。

## 🔧 API端點

### 獲取特定Session分析結果
```
GET /api/session/b19e3815-6cb8-4221-a273-3818d1c9f6cc
```

回應格式：
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
┌─────────────────┐    ┌─────────────────┐
│   LINE Bot      │    │   Web Browser   │
│                 │    │                 │
│ 發送特定URL     │    │ 手動輸入查詢    │
│ 到網站          │    │ 並開始分析      │
└─────────────────┘    └─────────────────┘
         │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   Nginx         │
                    │   (反向代理)    │
                    └─────────────────┘
                                 │
                    ┌─────────────────┐
                    │   React App     │
                    │   (前端)        │
                    └─────────────────┘
                                 │
                    ┌─────────────────┐
                    │   Node.js API   │
                    │   (後端)        │
                    └─────────────────┘
                                 │
                    ┌─────────────────┐
                    │   Session Data  │
                    │   (靜態文件)    │
                    └─────────────────┘
```

## 📁 項目結構

```
UI4/
├── echo_debate_of_school_project/    # 前端React應用
├── server/                          # 後端Node.js API
├── session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json  # 靜態session數據
├── Dockerfile                       # Docker配置
├── docker-compose.yml              # Docker Compose配置
├── nginx.conf                      # Nginx配置
├── simple-deploy.sh                # 簡化部署腳本
└── SIMPLE_README.md               # 簡化說明文件
```

## 🚀 雲端部署

### AWS EC2
1. 啟動EC2實例
2. 安裝Docker和Docker Compose
3. 上傳項目文件
4. 執行 `./simple-deploy.sh`

### Google Cloud Platform
1. 創建Compute Engine實例
2. 安裝Docker和Docker Compose
3. 上傳項目文件
4. 執行 `./simple-deploy.sh`

### Azure
1. 創建Virtual Machine
2. 安裝Docker和Docker Compose
3. 上傳項目文件
4. 執行 `./simple-deploy.sh`

## 🛠️ 維護

### 查看日誌
```bash
docker-compose logs -f
```

### 重啟服務
```bash
docker-compose restart
```

### 停止服務
```bash
docker-compose down
```

### 更新代碼
```bash
# 停止服務
docker-compose down

# 重新構建並啟動
docker-compose up -d --build
```

## 🔍 故障排除

### 常見問題

1. **無法訪問網站**
   - 檢查防火牆設置
   - 確認端口80和3000已開放
   - 查看容器日誌

2. **API無法響應**
   - 檢查後端服務狀態
   - 確認session數據文件存在
   - 查看API日誌

3. **前端無法載入**
   - 檢查nginx配置
   - 確認靜態文件路徑正確
   - 查看前端構建日誌

### 調試模式

```bash
# 查看詳細日誌
docker-compose logs -f fact-check-app

# 進入容器調試
docker-compose exec fact-check-app sh
```

## 📞 支持

如有問題，請檢查：
1. Docker和Docker Compose是否正確安裝
2. 端口80和3000是否可用
3. 防火牆設置是否正確
4. 查看容器日誌獲取詳細錯誤信息

---

**注意**: 這是一個簡化版本，主要用於演示特定session_id的載入功能。生產環境使用時請根據需要進行安全配置和性能優化。
