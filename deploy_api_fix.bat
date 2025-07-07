@echo off
echo ========================================
echo   Vercel API 404 修复部署脚本
echo ========================================
echo.

:: 设置编码为UTF-8
chcp 65001 >nul

:: 检查当前目录
echo 📁 当前目录: %CD%
echo.

:: 检查关键文件
echo 🔍 检查关键文件...
if exist "vercel.json" (
    echo ✅ vercel.json 存在
) else (
    echo ❌ vercel.json 不存在
    goto :error
)

if exist "api\openai.js" (
    echo ✅ api\openai.js 存在
) else (
    echo ❌ api\openai.js 不存在
    goto :error
)

if exist "api\hello.js" (
    echo ✅ api\hello.js 存在
) else (
    echo ❌ api\hello.js 不存在
    goto :error
)

if exist "api\diagnostic.js" (
    echo ✅ api\diagnostic.js 存在
) else (
    echo ❌ api\diagnostic.js 不存在
    goto :error
)

if exist "index.html" (
    echo ✅ index.html 存在
) else (
    echo ❌ index.html 不存在
    goto :error
)

echo.

:: 显示API目录内容
echo 📂 API 目录内容:
dir /b api\*.js 2>nul
echo.

:: 检查Git状态
echo 📋 Git 状态:
git status --porcelain
echo.

:: 询问是否继续
set /p continue="🚀 准备提交并推送更改到 GitHub。继续吗? (y/n): "
if /i not "%continue%"=="y" (
    echo 操作已取消。
    goto :end
)

:: Git 操作
echo.
echo 📤 执行 Git 操作...

:: 添加所有更改
echo 正在添加文件...
git add .

:: 检查是否有更改需要提交
git diff --cached --quiet
if %ERRORLEVEL% EQU 0 (
    echo ℹ️  没有新的更改需要提交。
    goto :push_check
)

:: 提交更改
echo 正在提交更改...
git commit -m "fix: 解决 Vercel API 404 问题 - 修复 index.html, 优化 vercel.json, 添加诊断工具"

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git 提交失败
    goto :error
)

:push_check
:: 推送到远程仓库
echo 正在推送到 GitHub...
git push origin main

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git 推送失败
    echo 💡 请检查网络连接和 GitHub 权限
    goto :error
)

echo.
echo ✅ 成功推送到 GitHub!
echo.

:: 显示下一步操作
echo ========================================
echo           📋 下一步操作
echo ========================================
echo.
echo 1. 等待 Vercel 自动部署完成（通常需要1-3分钟）
echo.
echo 2. 检查 Vercel 环境变量设置：
echo    - AZURE_OPENAI_API_KEY
echo    - AZURE_OPENAI_ENDPOINT
echo.
echo 3. 使用诊断工具验证修复效果：
echo    - 访问: https://your-app.vercel.app/api-404-diagnosis.html
echo    - 点击 "🚀 测试所有API端点"
echo.
echo 4. 测试主要端点：
echo    - https://your-app.vercel.app/api/hello
echo    - https://your-app.vercel.app/api/diagnostic
echo    - https://your-app.vercel.app/api/openai
echo.
echo 5. 如果问题仍然存在，请检查 Vercel 函数日志
echo.
echo ========================================

goto :end

:error
echo.
echo ❌ 部署过程中发生错误
echo 💡 请检查错误信息并重试
echo.
pause
exit /b 1

:end
echo.
echo 按任意键退出...
pause >nul
