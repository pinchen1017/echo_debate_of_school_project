# Google Cloud Platform 部署指南

## 優點
- 免費額度
- 自動擴展
- 全球CDN

## 部署步驟

### 1. 創建 GCP 帳戶
1. 訪問 https://cloud.google.com
2. 註冊帳戶（需要信用卡，但有免費額度）

### 2. 創建項目
1. 在 GCP 控制台創建新項目
2. 啟用 Compute Engine API

### 3. 創建 VM 實例
1. 進入 Compute Engine → VM instances
2. 點擊 "Create Instance"
3. 配置：
   - Name: fact-check-vm
   - Machine type: e2-micro（免費）
   - Boot disk: Ubuntu 20.04 LTS
   - Firewall: Allow HTTP and HTTPS traffic

### 4. 連接到實例
```bash
# 使用 gcloud 連接到實例
gcloud compute ssh fact-check-vm --zone=your-zone
```

### 5. 安裝 Docker
```bash
# 更新系統
sudo apt update

# 安裝 Docker
sudo apt install -y docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker $USER

# 重新登入
exit
gcloud compute ssh fact-check-vm --zone=your-zone
```

### 6. 上傳項目
```bash
# 創建項目目錄
mkdir fact-check-system
cd fact-check-system

# 使用 gcloud 上傳文件
gcloud compute scp --recurse . fact-check-vm:~/fact-check-system/ --zone=your-zone
```

### 7. 部署應用
```bash
# 進入項目目錄
cd fact-check-system

# 構建並啟動
docker-compose up -d --build

# 檢查狀態
docker-compose ps
```

### 8. 配置防火牆
```bash
# 允許 HTTP 和 HTTPS 流量
gcloud compute firewall-rules create allow-http-https \
    --allow tcp:80,tcp:443 \
    --source-ranges 0.0.0.0/0 \
    --target-tags http-server,https-server
```

### 9. 測試
訪問您的 VM 實例的外部 IP：
- 首頁: http://your-vm-ip
- 特定session: http://your-vm-ip/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc

## 免費額度
- 每月 1 個 e2-micro 實例
- 30GB 標準持久磁盤
- 1GB 網絡出口流量
