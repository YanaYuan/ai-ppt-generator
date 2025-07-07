@echo off
cls
echo ===============================================
echo   🚀 Vercel 部署准备脚本 
echo ===============================================
echo.

echo 📋 检查清单:
echo.

echo 1. 必要文件检查...
set "files_ok=true"

if exist "api\openai.js" (
    echo ✅ api\openai.js 存在
) else (
    echo ❌ api\openai.js 缺失
    set "files_ok=false"
)

if exist "api\vision.js" (
    echo ✅ api\vision.js 存在
) else (
    echo ❌ api\vision.js 缺失
    set "files_ok=false"
)

if exist "api\hello.js" (
    echo ✅ api\hello.js 存在
) else (
    echo ❌ api\hello.js 缺失
    set "files_ok=false"
)

if exist "vercel.json" (
    echo ✅ vercel.json 存在
) else (
    echo ❌ vercel.json 缺失
    set "files_ok=false"
)

if exist "ai-ppt-generator.html" (
    echo ✅ ai-ppt-generator.html 存在
) else (
    echo ❌ ai-ppt-generator.html 缺失
    set "files_ok=false"
)

if exist "api-diagnosis.html" (
    echo ✅ api-diagnosis.html 存在
) else (
    echo ❌ api-diagnosis.html 缺失
    set "files_ok=false"
)

echo.

if "%files_ok%"=="true" (
    echo ✅ 所有必要文件都存在
) else (
    echo ❌ 有文件缺失，请检查
    pause
    exit /b 1
)

echo.
echo 2. 显示当前目录结构...
echo.
tree /f /a
echo.

echo 3. 部署步骤提醒...
echo.
echo 📤 上传到 Vercel 的步骤:
echo.
echo   1️⃣ 登录 Vercel 控制台 (vercel.com)
echo   2️⃣ 点击 "New Project"
echo   3️⃣ 上传这个文件夹或连接 Git 仓库
echo   4️⃣ 设置环境变量:
echo      - AZURE_OPENAI_API_KEY: 您的 Azure OpenAI API 密钥
echo      - AZURE_OPENAI_ENDPOINT: 您的 Azure OpenAI 端点
echo   5️⃣ 点击 "Deploy"
echo.
echo 🧪 部署后测试:
echo   - 访问主应用: https://your-app.vercel.app/
echo   - 访问诊断页面: https://your-app.vercel.app/api-diagnosis.html
echo.

echo 4. 关键修复说明...
echo.
echo 🔧 本次修复的关键问题:
echo   - 更新了 vercel.json 配置格式
echo   - 从旧的 builds+routes 改为新的 functions+rewrites
echo   - 这应该解决 API 404 问题
echo.

set /p open_vercel=是否在浏览器中打开 Vercel 控制台? (y/n): 
if /i "%open_vercel%"=="y" (
    start https://vercel.com/dashboard
)

echo.
echo ✅ 准备工作完成！
echo 📁 当前目录包含了所有部署需要的文件
echo 🔗 请按照上述步骤进行 Vercel 部署
echo.
pause
