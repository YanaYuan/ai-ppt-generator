@echo off
echo ========================================
echo      Vercel 部署状态检查
echo ========================================
echo.

:: 设置编码为UTF-8
chcp 65001 >nul

echo 🔍 检查部署状态...
echo.

:: 检查本地文件状态
echo 📁 本地文件检查:
if exist "vercel.json" (
    echo ✅ vercel.json 存在
) else (
    echo ❌ vercel.json 缺失
)

if exist "api\openai.js" (
    echo ✅ api\openai.js 存在
) else (
    echo ❌ api\openai.js 缺失
)

if exist "api\diagnostic.js" (
    echo ✅ api\diagnostic.js 存在
) else (
    echo ❌ api\diagnostic.js 缺失
)

if exist "index.html" (
    echo ✅ index.html 存在
) else (
    echo ❌ index.html 缺失
)

echo.

:: 显示 Git 状态
echo 📋 Git 状态:
git status --short 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 不是 Git 仓库或 Git 不可用
)
echo.

:: 显示最近的提交
echo 📝 最近的提交:
git log --oneline -5 2>nul
echo.

:: 检查远程分支状态
echo 🌐 远程状态:
git status -b --porcelain 2>nul
echo.

:: 提示手动检查事项
echo ========================================
echo         📋 手动检查清单
echo ========================================
echo.
echo 1. Vercel 项目设置:
echo    □ 环境变量 AZURE_OPENAI_API_KEY 已配置
echo    □ 环境变量 AZURE_OPENAI_ENDPOINT 已配置
echo    □ 项目正确连接到 GitHub 仓库
echo.
echo 2. 部署验证:
echo    □ 访问 https://your-app.vercel.app/
echo    □ 测试 https://your-app.vercel.app/api/hello
echo    □ 使用 https://your-app.vercel.app/api-404-diagnosis.html
echo.
echo 3. 功能测试:
echo    □ PPT 生成功能正常
echo    □ 图像识别功能正常
echo    □ 错误信息显示正确
echo.
echo ========================================

echo.
echo 按任意键退出...
pause >nul
