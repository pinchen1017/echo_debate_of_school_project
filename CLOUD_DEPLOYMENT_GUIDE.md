# 事實查核系統雲端部署完整指南

## 🎯 目標
將事實查核系統部署到雲端，讓任何網域都能訪問，特別是支援：
- 首頁: `https://your-domain.com`
- 特定session: `https://your-domain.com/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc`

## 📋 部署前準備

### 1. 準備部署包
```bash
# 執行準備腳本
chmod +x prepare-for-cloud.sh
./prepare-for-cloud.sh
```

### 2. 檢查文件結構
確保以下文件存在：
```
UI4/
├── Dockerfile
├── docker-compose.yml
├── nginx.conf
├── start.sh
├── server/
│   ├── index.js
│   └── package.json
├── echo_debate_of_school_project/
│   └── dist/ (構建後的前端文件)
└── session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json
```

## 🌐 雲端部署選項

### 選項一：Render.com（推薦新手）

**優點**：
- 免費方案可用
- 自動部署
- 自動SSL證書
- 簡單易用

**步驟**：
1. 訪問 https://render.com 註冊帳戶
2. 將代碼推送到 GitHub
3. 在 Render 中創建 Web Service
4. 選擇 Docker 環境
5. 等待自動部署完成

**詳細指南**：查看 `render-deploy.md`

### 選項二：AWS EC2（推薦進階用戶）

**優點**：
- 完全控制
- 可擴展性強
- 專業級服務

**步驟**：
1. 創建 AWS 帳戶
2. 啟動 EC2 實例
3. 安裝 Docker
4. 上傳並部署應用

**詳細指南**：查看 `aws-deploy.md`

### 選項三：Google Cloud Platform

**優點**：
- 免費額度
- 自動擴展
- 全球CDN

**步驟**：
1. 創建 GCP 帳戶
2. 創建 VM 實例
3. 安裝 Docker
4. 部署應用

**詳細指南**：查看 `gcp-deploy.md`

## 🔧 部署後配置

### 1. 域名配置
如果您有自己的域名：

#### 使用 Cloudflare（推薦）
1. 註冊 Cloudflare 帳戶
2. 添加您的域名
3. 將 DNS 記錄指向您的雲端服務器
4. 啟用 SSL/TLS 加密

#### 使用 AWS Route 53
1. 在 Route 53 中註冊域名
2. 創建 A 記錄指向您的服務器 IP
3. 申請 SSL 證書

### 2. SSL 證書配置
大多數雲端平台會自動提供 SSL 證書，但如果您需要自定義：

```bash
# 使用 Let's Encrypt（在服務器上執行）
sudo apt install certbot
sudo certbot --nginx -d your-domain.com
```

## 🧪 測試部署

### 1. 基本功能測試
```bash
# 測試健康檢查
curl https://your-domain.com/api/health

# 測試特定session
curl https://your-domain.com/api/session/b19e3815-6cb8-4221-a273-3818d1c9f6cc
```

### 2. 前端測試
- 訪問首頁：`https://your-domain.com`
- 訪問特定session：`https://your-domain.com/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc`
- 測試事實查核功能

### 3. 性能測試
```bash
# 使用 curl 測試響應時間
time curl https://your-domain.com

# 使用 ab 進行壓力測試
ab -n 100 -c 10 https://your-domain.com/
```

## 📊 監控和維護

### 1. 日誌監控
```bash
# 查看應用日誌
docker-compose logs -f

# 查看 nginx 日誌
docker-compose exec fact-check-app tail -f /var/log/nginx/access.log
```

### 2. 性能監控
- 監控 CPU 和內存使用率
- 監控網絡流量
- 設置告警通知

### 3. 備份策略
```bash
# 備份數據
docker-compose exec fact-check-app tar -czf backup-$(date +%Y%m%d).tar.gz /app/data

# 定期備份（添加到 crontab）
0 2 * * * /path/to/backup-script.sh
```

## 🔒 安全配置

### 1. 防火牆設置
```bash
# 只允許必要端口
ufw allow 22    # SSH
ufw allow 80    # HTTP
ufw allow 443   # HTTPS
ufw enable
```

### 2. 環境變數安全
```bash
# 設置強密碼
export JWT_SECRET="your-super-secret-jwt-key"
export VITE_COFACT_TOKEN="your-cofact-token"
```

### 3. 定期更新
```bash
# 更新系統
sudo apt update && sudo apt upgrade

# 更新 Docker 鏡像
docker-compose pull
docker-compose up -d
```

## 🚨 故障排除

### 常見問題

1. **無法訪問網站**
   - 檢查防火牆設置
   - 確認端口是否開放
   - 查看容器狀態

2. **SSL 證書問題**
   - 檢查證書是否過期
   - 確認域名配置正確
   - 重新申請證書

3. **性能問題**
   - 檢查資源使用率
   - 優化 nginx 配置
   - 考慮升級服務器

### 調試命令
```bash
# 檢查容器狀態
docker-compose ps

# 查看詳細日誌
docker-compose logs --tail=100

# 進入容器調試
docker-compose exec fact-check-app sh
```

## 📈 擴展和優化

### 1. 負載均衡
- 使用多個實例
- 配置負載均衡器
- 實現自動擴展

### 2. CDN 配置
- 使用 Cloudflare 或 AWS CloudFront
- 緩存靜態資源
- 加速全球訪問

### 3. 數據庫集成
- 添加 PostgreSQL 或 MongoDB
- 實現數據持久化
- 設置數據備份

## 💰 成本估算

### Render.com
- 免費方案：$0/月
- 付費方案：$7/月起

### AWS EC2
- t2.micro：免費（12個月）
- 域名：$12/年
- 數據傳輸：免費（1GB/月）

### Google Cloud
- e2-micro：免費（每月1個實例）
- 域名：$12/年
- 網絡：免費（1GB/月）

## 🎉 部署完成檢查清單

- [ ] 代碼已推送到 GitHub
- [ ] 雲端服務器已創建
- [ ] Docker 已安裝並運行
- [ ] 應用已成功部署
- [ ] 域名已配置
- [ ] SSL 證書已安裝
- [ ] 基本功能測試通過
- [ ] 特定session測試通過
- [ ] 性能測試通過
- [ ] 監控已設置
- [ ] 備份策略已實施

## 📞 支持

如果遇到問題：
1. 查看對應平台的詳細部署指南
2. 檢查日誌文件
3. 參考故障排除部分
4. 聯繫雲端平台支持

---

**祝您部署成功！** 🚀
