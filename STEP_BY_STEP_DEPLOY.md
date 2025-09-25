# 一步一步雲端部署指南

## 🎯 目標
讓您的事實查核系統可以在任何網域訪問，特別是：
- `https://your-domain.com/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc`

## 📋 第一步：準備代碼

### 1.1 檢查當前代碼
```bash
# 在您的項目目錄中執行
ls -la
```

確保您看到以下文件：
- `Dockerfile`
- `docker-compose.yml`
- `nginx.conf`
- `server/index.js`
- `session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json`

### 1.2 構建前端
```bash
# 進入前端目錄
cd echo_debate_of_school_project

# 安裝依賴
npm install

# 構建前端
npm run build

# 返回根目錄
cd ..
```

### 1.3 檢查構建結果
```bash
# 確認 dist 目錄已創建
ls echo_debate_of_school_project/dist/
```

## 📦 第二步：準備 GitHub 倉庫

### 2.1 創建 GitHub 倉庫
1. 訪問 https://github.com
2. 點擊 "New repository"
3. 倉庫名稱：`fact-check-system`
4. 設為 Public（免費方案需要）
5. 點擊 "Create repository"

### 2.2 上傳代碼到 GitHub
```bash
# 初始化 git（如果還沒有）
git init

# 添加所有文件
git add .

# 提交更改
git commit -m "Initial commit: Fact check system ready for deployment"

# 添加遠程倉庫
git remote add origin https://github.com/your-username/fact-check-system.git

# 推送到 GitHub
git push -u origin main
```

## 🚀 第三步：部署到 Render.com

### 3.1 創建 Render 帳戶
1. 訪問 https://render.com
2. 點擊 "Get Started for Free"
3. 使用 GitHub 帳戶登入

### 3.2 創建 Web Service
1. 在 Render 控制台點擊 "New +"
2. 選擇 "Web Service"
3. 連接您的 GitHub 倉庫

### 3.3 配置服務
填寫以下信息：
- **Name**: `fact-check-system`
- **Environment**: `Docker`
- **Region**: 選擇離您最近的區域（如 Singapore）
- **Branch**: `main`
- **Root Directory**: 留空
- **Dockerfile Path**: `Dockerfile`
- **Docker Context**: 留空

### 3.4 環境變數設置
在 "Environment Variables" 部分添加：
```
NODE_ENV=production
PORT=3000
```

### 3.5 開始部署
1. 點擊 "Create Web Service"
2. 等待構建完成（約 5-10 分鐘）
3. 查看構建日誌確認沒有錯誤

## 🌐 第四步：獲取域名

### 4.1 獲取 Render 域名
部署完成後，您會得到一個類似這樣的域名：
```
https://fact-check-system.onrender.com
```

### 4.2 測試基本功能
1. 訪問首頁：`https://fact-check-system.onrender.com`
2. 測試特定session：`https://fact-check-system.onrender.com/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc`

## 🔧 第五步：配置自定義域名（可選）

### 5.1 購買域名
1. 在 Namecheap、GoDaddy 或其他域名註冊商購買域名
2. 例如：`your-fact-check.com`

### 5.2 在 Render 中添加自定義域名
1. 在 Render 控制台選擇您的服務
2. 進入 "Settings" → "Custom Domains"
3. 添加您的域名
4. 按照指示配置 DNS 記錄

### 5.3 配置 DNS
在您的域名註冊商處添加 CNAME 記錄：
```
Type: CNAME
Name: www
Value: fact-check-system.onrender.com
```

## 🧪 第六步：測試部署

### 6.1 功能測試
```bash
# 測試 API 健康檢查
curl https://your-domain.com/api/health

# 測試特定 session
curl https://your-domain.com/api/session/b19e3815-6cb8-4221-a273-3818d1c9f6cc
```

### 6.2 前端測試
1. 訪問首頁，確認頁面正常載入
2. 訪問特定session URL，確認自動載入分析結果
3. 測試事實查核功能

### 6.3 性能測試
```bash
# 測試響應時間
time curl https://your-domain.com
```

## 📊 第七步：監控和維護

### 7.1 查看日誌
在 Render 控制台：
1. 選擇您的服務
2. 點擊 "Logs" 標籤
3. 查看實時日誌

### 7.2 設置監控
1. 在 Render 控制台設置告警
2. 監控服務狀態
3. 設置自動重啟

## 🚨 故障排除

### 常見問題

1. **構建失敗**
   - 檢查 Dockerfile 語法
   - 確認所有必要文件都存在
   - 查看構建日誌

2. **服務無法啟動**
   - 檢查環境變數設置
   - 確認端口配置
   - 查看運行日誌

3. **無法訪問特定session**
   - 確認 session 數據文件存在
   - 檢查 API 端點是否正常
   - 查看瀏覽器控制台錯誤

### 調試步驟
1. 查看 Render 控制台的日誌
2. 檢查瀏覽器開發者工具
3. 測試 API 端點
4. 確認文件路徑正確

## 🎉 部署完成

部署成功後，您將擁有：
- 一個可公開訪問的網站
- 自動 SSL 證書
- 自動部署（當您推送代碼到 GitHub 時）
- 基本的監控和日誌

### 最終測試 URL
- 首頁：`https://your-domain.com`
- 特定session：`https://your-domain.com/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc`

## 📞 需要幫助？

如果遇到問題：
1. 查看 Render 的文檔：https://render.com/docs
2. 檢查 GitHub 倉庫的 Issues
3. 查看本項目的故障排除部分

---

**恭喜！您的事實查核系統現在已經部署到雲端了！** 🎉
