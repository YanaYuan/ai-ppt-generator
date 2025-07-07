@echo off
echo =============================================
echo   Vercel API 部署快速修复脚本
echo =============================================
echo.

echo 1. 检查必要文件是否存在...
if not exist "api\openai.js" (
    echo ❌ 缺少 api\openai.js
    goto :error
) else (
    echo ✅ api\openai.js 存在
)

if not exist "api\vision.js" (
    echo ❌ 缺少 api\vision.js
    goto :error
) else (
    echo ✅ api\vision.js 存在
)

if not exist "api\hello.js" (
    echo ❌ 缺少 api\hello.js
    goto :error
) else (
    echo ✅ api\hello.js 存在
)

if not exist "vercel.json" (
    echo ❌ 缺少 vercel.json
    goto :error
) else (
    echo ✅ vercel.json 存在
)

if not exist "ai-ppt-generator.html" (
    echo ❌ 缺少 ai-ppt-generator.html
    goto :error
) else (
    echo ✅ ai-ppt-generator.html 存在
)

echo.
echo 2. 检查 Git 状态...
git status --porcelain > temp_git_status.txt
for /f %%i in ("temp_git_status.txt") do set size=%%~zi
if %size% gtr 0 (
    echo ⚠️  有未提交的更改:
    git status --porcelain
    echo.
    set /p commit_choice=是否提交更改? (y/n): 
    if /i "!commit_choice!"=="y" (
        git add .
        git commit -m "Fix Vercel API deployment issues"
        echo ✅ 更改已提交
    )
) else (
    echo ✅ 没有未提交的更改
)
del temp_git_status.txt

echo.
echo 3. 显示部署检查清单...
echo.
echo 📋 Vercel 部署检查清单:
echo ✅ 1. API 文件已就绪
echo ✅ 2. vercel.json 配置已更新
echo ⚠️  3. 请确保在 Vercel 控制台设置环境变量:
echo      - AZURE_OPENAI_API_KEY
echo      - AZURE_OPENAI_ENDPOINT
echo ⚠️  4. 部署后访问 https://your-app.vercel.app/api-diagnosis.html 进行测试
echo.

echo 4. 可用的测试命令:
echo.
echo 本地测试 (如果安装了 Vercel CLI):
echo   vercel dev
echo.
echo 部署到 Vercel:
echo   vercel --prod
echo.
echo 测试 API (部署后):
echo   curl https://your-app.vercel.app/api/hello
echo.

set /p open_diagnosis=是否打开诊断页面模板? (y/n): 
if /i "%open_diagnosis%"=="y" (
    start api-diagnosis.html
)

echo.
echo ✅ 修复脚本完成!
echo 请按照上述清单完成 Vercel 部署。
pause
goto :end

:error
echo.
echo ❌ 发现问题，请检查文件结构。
pause

:end
