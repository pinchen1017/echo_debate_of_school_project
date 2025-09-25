import { useState, useEffect } from 'react'
import './css/App.css'
import Header from './header'
import HomePage from './HomePage'
import FactCheck from './fact_check'
import AboutUs from './aboutus'
import Trending from './trending'
import Footer from './footer'
import Analysis from './analysis'
import RealTimeAnalysisPage from './pages/RealTimeAnalysisPage'

function App() {
  // 狀態設定
  const [currentTab, setCurrentTab] = useState('home') // 改為默認顯示首頁
  const [analysisState, setAnalysisState] = useState({ modelKey: null, data: null })
  const [searchQuery, setSearchQuery] = useState('')
  const [analysisResult, setAnalysisResult] = useState(null)
  const [showRealTimeAnalysis, setShowRealTimeAnalysis] = useState(false)

<<<<<<< HEAD
  // 檢查URL路由
=======
  // 頁面切換函數 - 強制滾動到最上層
  const handleTabChange = (tab) => {
    setCurrentTab(tab);
    // 強制滾動到頁面最上層
    window.scrollTo({
      top: 0,
      left: 0,
      behavior: 'smooth'
    });
  }

  // 檢查URL路由和session_id參數
>>>>>>> 38f50bc (佈署中失敗，重新建置doccker)
  useEffect(() => {
    const path = window.location.pathname;
    const urlParams = new URLSearchParams(window.location.search);
    const sessionId = urlParams.get('session_id');
    
    if (path.startsWith('/r/')) {
      setShowRealTimeAnalysis(true);
    } else if (sessionId === 'b19e3815-6cb8-4221-a273-3818d1c9f6cc') {
      // 如果是特定的session_id，自動載入分析結果
      setSearchQuery('國高中改10點上課現在實施中'); // 設置搜尋查詢
      setCurrentTab('fact_check'); // 切換到事實查核頁面
      loadSessionAnalysis(sessionId);
    } else {
      setShowRealTimeAnalysis(false);
    }
  }, []);

  // 載入session分析結果的函數
  const loadSessionAnalysis = async (sessionId) => {
    try {
      // 使用相對路徑，自動適應當前域名
      const response = await fetch(`/api/session/${sessionId}`);
      if (response.ok) {
        const data = await response.json();
        if (data.analysisResult) {
          setAnalysisResult(data.analysisResult);
        }
      }
    } catch (error) {
      console.error('載入session分析結果失敗:', error);
    }
  };

  // 最新資料
  
  const factChecks = [
    {
      id: 1,
      title: "網傳某政治人物擁有海外秘密帳戶？",
      category: "政治",
      status: "已查證",
      result: "假消息",
      date: "2024-01-15",
      summary: "經查證，該傳言缺乏具體證據支持，相關指控已被當事人否認。",
      author: "張小明"
    },
    {
      id: 2,
      title: "某品牌食品含有致癌物質？",
      category: "健康",
      status: "已查證",
      result: "部分真實",
      date: "2024-01-14",
      summary: "該品牌部分產品確實含有微量相關物質，但含量遠低於安全標準。",
      author: "李華"
    },
    {
      id: 3,
      title: "某地區將實施新的交通管制措施？",
      category: "政策",
      status: "已查證",
      result: "真實",
      date: "2024-01-13",
      summary: "相關政策文件已正式發布，將於下月開始實施。",
      author: "王美"
    },
    {
      id: 4,
      title: "AI生成的假新聞正在影響選舉結果？",
      category: "科技",
      status: "已查證",
      result: "真實",
      date: "2024-01-12",
      summary: "研究顯示AI生成的假新聞確實對選舉產生影響，需要加強監管。",
      author: "陳科技"
    },
    {
      id: 5,
      title: "某明星被拍到在餐廳與神秘人物會面？",
      category: "娛樂",
      status: "已查證",
      result: "假消息",
      date: "2024-01-11",
      summary: "照片經過PS處理，實際上是多年前的舊照片。",
      author: "劉娛樂"
    },
    {
      id: 6,
      title: "新型疫苗會改變人體DNA？",
      category: "科學",
      status: "已查證",
      result: "假消息",
      date: "2024-01-10",
      summary: "科學證據明確顯示，mRNA疫苗不會改變人體DNA。",
      author: "趙科學"
    }
  ]

  // 如果顯示實時分析頁面，直接渲染該頁面
  if (showRealTimeAnalysis) {
    return <RealTimeAnalysisPage />;
  }

  // 網頁顯現
  return (
    <div className="app">
      {/*Header*/}
      <Header currentTab={currentTab} onTabChange={setCurrentTab} />

      {/*Content*/}
      {currentTab === 'home' ? (
        <HomePage onTabChange={setCurrentTab} />
      ) : currentTab === 'trending' ? (
        <main className="main-content">
          <div className="content-wrapper">
            <Trending factChecks={factChecks} />
          </div>
        </main>
      ) : currentTab === 'fact_check' ? (
        <main className="main-content">
          <div className="content-wrapper">
            <FactCheck 
              searchQuery={searchQuery} 
              factChecks={factChecks} 
              setSearchQuery={setSearchQuery}
              analysisResult={analysisResult}
              setAnalysisResult={setAnalysisResult}
              onOpenAnalysis={(modelKey, data) => { setAnalysisState({ modelKey, data }); setCurrentTab('analysis'); }}
              onStartRealTimeAnalysis={() => setShowRealTimeAnalysis(true)}
            />
          </div>
        </main>
      ) : currentTab === 'analysis' ? (
        <main className="main-content">
          <div className="content-wrapper">
            <Analysis 
              modelKey={analysisState.modelKey} 
              data={analysisState.data} 
              onBack={() => setCurrentTab('fact_check')}
            />
          </div>
        </main>
      ) : (
        <main className="main-content">
          <div className="content-wrapper">
            <AboutUs />
          </div>
        </main>
      )}

      {/*footer*/}
      <Footer />

    </div>
  )
}

export default App