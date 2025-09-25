# 修復 Render 構建權限問題

## 🚨 當前問題
```
sh: 1: vite: Permission denied
==> Build failed 😞
```

## ✅ 解決方案

### 方案一：修改 Render 構建命令（推薦）

在 Render 控制台中，將 **Build Command** 改為：

```bash
cd echo_debate_of_school_project && npm install && npx vite build
```

**步驟**：
1. 在 Render 控制台選擇您的服務
2. 點擊 "Settings"
3. 找到 "Build Command" 欄位
4. 將內容改為：`cd echo_debate_of_school_project && npm install && npx vite build`
5. 點擊 "Save Changes"
6. 觸發重新部署

### 方案二：使用 npm run build

如果方案一不行，嘗試：

```bash
cd echo_debate_of_school_project && npm install && npm run build
```

### 方案三：完整的構建命令

如果還是不行，使用完整的路徑：

```bash
cd echo_debate_of_school_project && npm ci && npx vite build && cd ../server && npm ci
```

## 🔧 為什麼會出現這個問題？

1. **權限問題**：`vite` 命令沒有執行權限
2. **路徑問題**：構建命令沒有正確切換到前端目錄
3. **依賴問題**：`vite` 沒有正確安裝

## 🚀 推薦的 Render 配置

### Build Command
```bash
cd echo_debate_of_school_project && npm install && npx vite build
```

### Start Command
```bash
cd server && npm install && npm start
```

### 環境變數
```
NODE_ENV=production
PORT=3000
```

## 📋 測試步驟

1. 修改構建命令
2. 保存設置
3. 觸發重新部署
4. 監控構建日誌
5. 檢查是否成功

## 🚨 如果還是有問題

嘗試以下替代方案：

### 替代方案 1：使用 yarn
```bash
cd echo_debate_of_school_project && yarn install && yarn build
```

### 替代方案 2：使用完整路徑
```bash
cd echo_debate_of_school_project && npm install && ./node_modules/.bin/vite build
```

### 替代方案 3：分步構建
```bash
cd echo_debate_of_school_project && npm install
npx vite build
cd ../server && npm install
```

## 🎯 關鍵要點

- 使用 `npx vite build` 而不是 `vite build`
- 確保在正確的目錄中執行命令
- 先安裝依賴再構建
- 監控構建日誌找出具體問題
