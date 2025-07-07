@echo off
echo ====================================
echo AI PPT Generator - GitHub上传脚本
echo ====================================
echo.

echo 1. 初始化Git仓库...
git init
if %errorlevel% neq 0 (
    echo 错误: Git初始化失败，请确保已安装Git
    pause
    exit /b 1
)

echo 2. 添加所有文件到Git...
git add .
if %errorlevel% neq 0 (
    echo 错误: 添加文件失败
    pause
    exit /b 1
)

echo 3. 创建初始提交...
git commit -m "v5.0: AI PPT Generator with environment adaptation and OCR features"
if %errorlevel% neq 0 (
    echo 错误: 创建提交失败
    pause
    exit /b 1
)

echo.
echo ====================================
echo 接下来需要您手动操作：
echo ====================================
echo.
echo 1. 打开浏览器，访问 https://github.com/new
echo 2. 创建新仓库：
echo    - 仓库名: ai-ppt-generator
echo    - 描述: AI PPT组件生成器 - 智能生成专业PPT组件，支持图片文字识别
echo    - 设为公开仓库
echo    - 不要初始化README（我们已经有了）
echo.
echo 3. 创建完成后，GitHub会显示类似这样的命令：
echo    git remote add origin https://github.com/你的用户名/ai-ppt-generator.git
echo    git branch -M main
echo    git push -u origin main
echo.
echo 4. 复制GitHub显示的命令到此窗口执行
echo.
echo 等待您的操作...
echo.
pause

echo 5. 请输入您的GitHub用户名:
set /p username=用户名: 

echo.
echo 6. 连接到您的GitHub仓库...
git remote add origin https://github.com/%username%/ai-ppt-generator.git
if %errorlevel% neq 0 (
    echo 错误: 连接远程仓库失败
    pause
    exit /b 1
)

echo 7. 设置主分支...
git branch -M main
if %errorlevel% neq 0 (
    echo 错误: 设置分支失败
    pause
    exit /b 1
)

echo 8. 推送代码到GitHub...
echo 注意: 如果是第一次推送，可能需要您登录GitHub
git push -u origin main
if %errorlevel% neq 0 (
    echo 错误: 推送失败，请检查网络连接和GitHub登录状态
    pause
    exit /b 1
)

echo.
echo ====================================
echo 🎉 GitHub上传完成！
echo ====================================
echo.
echo 您的项目已成功上传到:
echo https://github.com/%username%/ai-ppt-generator
echo.
echo 接下来可以部署到Vercel:
echo 1. 访问 https://vercel.com
echo 2. 点击 "New Project"
echo 3. 导入刚创建的GitHub仓库
echo 4. 配置环境变量（详见DEPLOYMENT_GUIDE.md）
echo 5. 点击部署
echo.
pause
