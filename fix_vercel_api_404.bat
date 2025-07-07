@echo off
echo ========================================
echo   Vercel API 404 彻底修复脚本
echo ========================================
echo.

echo [1/6] 检查项目结构...
if not exist "api\" (
    echo ERROR: api 目录不存在!
    pause
    exit /b 1
)

if not exist "vercel.json" (
    echo ERROR: vercel.json 不存在!
    pause
    exit /b 1
)

echo [2/6] 验证API文件...
for %%f in (api\*.js) do (
    echo 检查 %%f
    findstr /C:"module.exports" "%%f" > nul
    if errorlevel 1 (
        echo WARNING: %%f 可能没有正确的 module.exports
    )
)

echo [3/6] 清理不必要的文件...
if exist ".vercel\" (
    echo 删除本地 .vercel 缓存目录...
    rmdir /s /q ".vercel" 2>nul
)

echo [4/6] 验证关键文件...
echo 检查 package.json...
findstr /C:"node" "package.json" > nul
if errorlevel 1 (
    echo WARNING: package.json 可能缺少 Node.js 配置
)

echo 检查 vercel.json...
findstr /C:"@vercel/node" "vercel.json" > nul
if errorlevel 1 (
    echo WARNING: vercel.json 可能缺少 Node.js 构建配置
)

echo [5/6] 准备部署...
echo.
echo 准备推送到GitHub并部署到Vercel...
echo.
echo 请确保已经：
echo 1. 在Vercel后台设置了环境变量（AZURE_OPENAI_API_KEY, AZURE_OPENAI_ENDPOINT）
echo 2. GitHub仓库是最新的
echo 3. Vercel项目连接到正确的GitHub仓库
echo.

set /p confirm="是否继续部署? (y/n): "
if /i "%confirm%" neq "y" (
    echo 部署已取消
    pause
    exit /b 0
)

echo [6/6] 执行部署...
echo.
echo 推送到GitHub...
git add .
git commit -m "修复Vercel API 404问题: 更新package.json、vercel.json配置，优化API函数格式"
git push origin main

echo.
echo ========================================
echo   部署完成!
echo ========================================
echo.
echo 请等待2-3分钟让Vercel完成部署，然后：
echo 1. 访问 https://your-project.vercel.app/api/test
echo 2. 访问 https://your-project.vercel.app/api/hello
echo 3. 访问 https://your-project.vercel.app/api/diagnostic
echo.
echo 如果API仍然404，请检查：
echo 1. Vercel项目设置中的环境变量
echo 2. Vercel部署日志中的错误信息
echo 3. GitHub仓库是否正确连接
echo.
pause
