# 事實查核系統雲端部署指南

## 概述

本系統是一個多代理模型事實查核平台，支援從LINE透過session_id參數直接載入分析結果，以及透過網站進行事實查核分析。

## 系統架構

- **前端**: React + Vite 構建的單頁應用
- **後端**: Node.js + Express API服務器
- **部署**: Docker容器化部署，使用Nginx作為反向代理

## 功能特性

1. **LINE整合**: 支援透過URL參數`?session_id=<uuid>`直接載入分析結果
2. **事實查核**: 整合Cofact API和自建多代理模型分析
3. **實時分析**: 支援實時分析結果展示
4. **響應式設計**: 適配各種設備尺寸

## 部署步驟

### 1. 環境準備

確保您的系統已安裝：
- Docker
- Docker Compose
- Git

### 2. 配置環境變數

複製環境變數範例檔案：
```bash
cp env.example .env
```

編輯`.env`檔案，設置必要的環境變數：
```bash
# 後端環境變數
NODE_ENV=production
JWT_SECRET=your-super-secret-jwt-key-here
PORT=3000

# 前端環境變數
VITE_COFACT_TOKEN=your-cofact-api-token-here
```

### 3. 構建和部署

使用Docker Compose部署：
```bash
# 構建並啟動服務
docker-compose up -d --build

# 查看服務狀態
docker-compose ps

# 查看日誌
docker-compose logs -f
```

### 4. 驗證部署

訪問以下URL驗證部署：
- 前端應用: `http://your-domain.com`
- API健康檢查: `http://your-domain.com/api/health`
- 系統健康檢查: `http://your-domain.com/health`

## API使用說明

### 1. 開始分析

發送POST請求到 `/api/analyze`：

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

回應格式：
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

### 2. 獲取分析結果

發送GET請求到 `/api/session/{session_id}`：

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

## LINE整合

### URL格式

從LINE發送用戶到網站時，使用以下URL格式：
```
https://your-domain.com/?session_id=<uuid>
```

### 自動載入流程

1. 用戶點擊LINE中的連結
2. 前端檢測到`session_id`參數
3. 自動切換到事實查核頁面
4. 調用API獲取分析結果
5. 顯示完整的分析內容

## 雲端平台部署

### AWS部署

1. 使用AWS ECS或EC2部署Docker容器
2. 配置Application Load Balancer
3. 設置Route 53域名解析
4. 配置SSL證書

### Google Cloud Platform部署

1. 使用Cloud Run部署容器
2. 配置Cloud Load Balancing
3. 設置Cloud DNS
4. 配置SSL證書

### Azure部署

1. 使用Container Instances或App Service
2. 配置Application Gateway
3. 設置Azure DNS
4. 配置SSL證書

## 監控和維護

### 日誌查看

```bash
# 查看應用日誌
docker-compose logs -f fact-check-app

# 查看nginx日誌
docker-compose exec fact-check-app tail -f /var/log/nginx/access.log
docker-compose exec fact-check-app tail -f /var/log/nginx/error.log
```

### 健康檢查

系統提供多層健康檢查：
- 容器級別：Docker健康檢查
- 應用級別：`/health`端點
- API級別：`/api/health`端點

### 備份和恢復

建議定期備份：
- 環境變數配置
- 日誌文件
- 數據庫數據（如果使用）

## 故障排除

### 常見問題

1. **API無法訪問**
   - 檢查後端服務是否正常運行
   - 驗證nginx配置
   - 檢查防火牆設置

2. **前端無法載入**
   - 檢查靜態文件路徑
   - 驗證nginx配置
   - 檢查構建過程

3. **CORS錯誤**
   - 檢查nginx CORS配置
   - 驗證API端點設置

### 調試模式

啟用調試模式：
```bash
# 設置環境變數
export NODE_ENV=development

# 重新構建並啟動
docker-compose up -d --build
```

## 安全考慮

1. **環境變數安全**
   - 使用強密碼作為JWT_SECRET
   - 定期輪換API密鑰
   - 不要在代碼中硬編碼敏感信息

2. **網絡安全**
   - 配置適當的防火牆規則
   - 使用HTTPS加密傳輸
   - 設置適當的CORS策略

3. **容器安全**
   - 定期更新基礎鏡像
   - 使用非root用戶運行容器
   - 掃描容器漏洞

## 性能優化

1. **前端優化**
   - 啟用Gzip壓縮
   - 設置適當的緩存策略
   - 使用CDN加速靜態資源

2. **後端優化**
   - 實現API響應緩存
   - 使用連接池
   - 優化數據庫查詢

3. **基礎設施優化**
   - 使用負載均衡
   - 配置自動擴展
   - 監控資源使用情況

## 聯繫支持

如有問題，請聯繫開發團隊或查看項目文檔。
