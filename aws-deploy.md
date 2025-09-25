# AWS EC2 部署指南

## 優點
- 完全控制
- 可擴展性強
- 專業級服務

## 部署步驟

### 1. 創建 AWS 帳戶
1. 訪問 https://aws.amazon.com
2. 註冊帳戶（需要信用卡）

### 2. 啟動 EC2 實例
1. 登入 AWS 控制台
2. 進入 EC2 服務
3. 點擊 "Launch Instance"
4. 選擇 Amazon Linux 2 AMI
5. 選擇 t2.micro（免費方案）
6. 配置安全組：
   - HTTP (80)
   - HTTPS (443)
   - SSH (22)
   - 自定義 TCP (3000)

### 3. 連接到實例
```bash
# 使用 SSH 連接到您的實例
ssh -i your-key.pem ec2-user@your-instance-ip
```

### 4. 安裝 Docker
```bash
# 更新系統
sudo yum update -y

# 安裝 Docker
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user

# 安裝 Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 重新登入以應用群組變更
exit
ssh -i your-key.pem ec2-user@your-instance-ip
```

### 5. 上傳項目文件
```bash
# 創建項目目錄
mkdir fact-check-system
cd fact-check-system

# 使用 scp 上傳文件（在本地執行）
scp -i your-key.pem -r . ec2-user@your-instance-ip:~/fact-check-system/
```

### 6. 部署應用
```bash
# 進入項目目錄
cd fact-check-system

# 構建並啟動
docker-compose up -d --build

# 檢查狀態
docker-compose ps
```

### 7. 配置域名（可選）
1. 在 Route 53 中註冊域名
2. 創建 A 記錄指向您的 EC2 實例 IP
3. 申請 SSL 證書（使用 AWS Certificate Manager）

### 8. 測試
訪問您的 EC2 實例的公共 IP：
- 首頁: http://your-ec2-ip
- 特定session: http://your-ec2-ip/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc

## 成本估算
- EC2 t2.micro: 免費（12個月）
- 數據傳輸: 免費（1GB/月）
- 域名: $12/年（可選）
