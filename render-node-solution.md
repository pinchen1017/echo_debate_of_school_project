# Render Node.js 部署解決方案

## 🎯 問題
Docker 部署失敗，因為找不到 `dist` 目錄。

## ✅ 解決方案：使用 Node.js 環境

### 步驟 1：在 Render 中重新創建服務

1. **刪除現有的 Web Service**
   - 在 Render 控制台找到您的服務
   - 點擊 "Settings" → "Delete Service"

2. **創建新的 Web Service**
   - 點擊 "New +" → "Web Service"
   - 連接您的 GitHub 倉庫

3. **重要：選擇 Node.js 環境**
   - **Environment**: 選擇 `Node`（不是 Docker）
   - **Build Command**: `npm run build`
   - **Start Command**: `npm start`
   - **Node Version**: `18`

### 步驟 2：環境變數設置
```
NODE_ENV=production
PORT=3000
```

### 步驟 3：提交代碼
```bash
git add .
git commit -m "Fix deployment: switch to Node.js environment"
git push origin main
```

## 🔧 為什麼這樣能解決問題？

1. **Node.js 環境會自動執行構建命令**
   - `npm run build` 會構建前端
   - 生成 `dist` 目錄
   - 然後啟動後端服務

2. **後端已經配置為服務靜態文件**
   - 後端會自動服務前端的 `dist` 目錄
   - 處理所有路由

3. **更簡單的部署流程**
   - 不需要 Docker 配置
   - 自動處理依賴安裝
   - 更少的錯誤

## 🚀 部署成功後

您將能夠訪問：
- 首頁: `https://your-app-name.onrender.com`
- 特定session: `https://your-app-name.onrender.com/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc`

## 📋 檢查清單

- [ ] 刪除現有的 Docker Web Service
- [ ] 創建新的 Node.js Web Service
- [ ] 設置正確的 Build Command 和 Start Command
- [ ] 添加環境變數
- [ ] 推送代碼到 GitHub
- [ ] 監控部署日誌

## 🧪 測試

部署完成後，測試以下功能：
1. 訪問首頁
2. 訪問特定 session URL
3. 測試 API 端點
4. 測試事實查核功能
