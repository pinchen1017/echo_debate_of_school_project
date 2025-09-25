# 快速修復部署問題

## 🚨 問題
您的 Docker 部署持續失敗，我們需要改用更簡單的方法。

## ✅ 解決方案：使用 Node.js 環境

### 步驟 1：刪除 Docker 相關文件
```bash
# 刪除 Dockerfile（暫時不需要）
del Dockerfile
del docker-compose.yml
del nginx.conf
del start.sh
```

### 步驟 2：修改後端代碼
需要修改 server/index.js，讓它同時服務前端靜態文件：

```javascript
import express from "express";
import cors from "cors";
import fs from "fs";
import path from "path";
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
app.use(cors());
app.use(express.json());

// 載入靜態session數據
const sessionData = JSON.parse(fs.readFileSync(path.join(__dirname, '../session-b19e3815-6cb8-4221-a273-3818d1c9f6cc.json'), 'utf8'));

// 服務前端靜態文件
app.use(express.static(path.join(__dirname, '../echo_debate_of_school_project/dist')));

app.get("/api/health", (_, res) => res.json({ ok: true }));

// 簡化的API端點 - 只提供特定session的數據
app.get("/api/session/:session_id", (req, res) => {
  const sessionId = req.params.session_id;
  
  if (sessionId === "b19e3815-6cb8-4221-a273-3818d1c9f6cc") {
    // 轉換session數據為前端需要的格式
    const analysisResult = convertSessionToAnalysisResult(sessionData);
    res.json({
      status: "done",
      progress: 1,
      overview: {
        verdict: "假消息",
        score_true: 0.18,
        last_updated: new Date().toISOString()
      },
      analysisResult: analysisResult
    });
  } else {
    res.status(404).json({ error: "Session not found" });
  }
});

// 處理所有其他路由，返回前端應用
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../echo_debate_of_school_project/dist/index.html'));
});

// 轉換session數據為前端需要的格式
function convertSessionToAnalysisResult(sessionData) {
  const state = sessionData.state;
  
  return {
    weight_calculation_json: {
      llm_label: "完全錯誤",
      llm_score: 0,
      slm_score: 0.9795,
      jury_score: -0.7244,
      final_score: 0.035
    },
    final_report_json: {
      topic: "國高中改10點上課現在實施中",
      overall_assessment: state.curation_raw || "分析結果",
      jury_score: 72,
      jury_brief: "證據不足。未全面實施，但提案已達附議門檻。",
      evidence_digest: [
        "公共政策網路參與平台：國高中改10點上課提案已達萬人附議門檻，教育部須於11/14前回應。",
        "教育部 (2017年類似提案處理)：曾有建議9點上課提案，最終未全面採納，僅放寬早自習彈性。",
        "教育部 (2022年作息調整)：修正發布作息注意事項，讓高中生第一節課前時間更有彈性，非全面延後。",
        "Yahoo新聞網路投票：超過六成參與者不贊成或完全不贊成國高中改為10點上課。",
        "社群觀察：學生普遍支持，家長、教育工作者多數反對或擔憂實際操作。"
      ],
      stake_summaries: [
        {
          side: "Advocate",
          thesis: "國高中改為上午10點上課的提案，旨在改善學生睡眠不足及提升學習效率，是符合學生福祉的改革方向。",
          strongest_points: [
            "提案已在公共政策網路參與平台獲得萬人附議，顯示強大民意支持。",
            "延後上課有助於改善學生睡眠品質，提升學習效率與身心發展。",
            "教育部需在11月14日前做出回應，顯示政策推動的可能性。"
          ],
          weaknesses: [
            "未能有效回應家長接送、交通、補習文化等實際衝擊。",
            "未充分說明如何解決課程時數壓縮與教學品質問題。",
            "過於樂觀看待教育部對提案的採納程度，忽略歷史經驗。"
          ]
        },
        {
          side: "Skeptic",
          thesis: "國高中改10點上課的提案，雖立意良善，但實際執行將對家庭作息、學校行政、教學品質及社會運作造成巨大衝擊，且社會反對聲浪高。",
          strongest_points: [
            "Yahoo新聞網路投票顯示超過六成民眾不贊成，反映社會主流意見。",
            "家長擔憂接送時間與自身工作衝突，增加家庭負擔。",
            "教育工作者擔憂課程時數壓縮與教學品質問題。",
            "過去類似提案(2017年9點上課)最終未被採納，僅放寬彈性。"
          ],
          weaknesses: [
            "未能充分考慮學生身心發展需求。",
            "過度保守，缺乏改革勇氣。",
            "未提出替代方案解決學生睡眠不足問題。"
          ]
        }
      ]
    },
    fact_check_result_json: {
      analysis: state.curation_raw || "根據目前的資料顯示，「國高中改10點上課現在實施中」的說法並不正確。",
      classification: "完全錯誤"
    },
    classification_json: {
      Probability: "0.07950027287006378",
      classification: "錯誤"
    }
  };
}

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
```

### 步驟 3：在 Render 中重新創建服務
1. 刪除現有的 Web Service
2. 創建新的 Web Service
3. 選擇 **Node** 環境（不是 Docker）
4. 配置：
   - Build Command: `npm run build`
   - Start Command: `npm start`
   - Environment: `Node`

### 步驟 4：提交並推送
```bash
git add .
git commit -m "Switch to Node.js deployment, remove Docker dependencies"
git push origin main
```

## 🎯 為什麼這樣更好？
1. **更簡單**：不需要 Docker 配置
2. **更可靠**：Render 的 Node.js 環境更穩定
3. **更快速**：構建時間更短
4. **更易調試**：錯誤信息更清晰

## 🚀 部署成功後
您將能夠訪問：
- 首頁: `https://your-app-name.onrender.com`
- 特定session: `https://your-app-name.onrender.com/?session_id=b19e3815-6cb8-4221-a273-3818d1c9f6cc`
