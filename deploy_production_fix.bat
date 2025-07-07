@echo off
echo ========================================
echo   AI PPT 生成器 - 生产环境修复部署
echo ========================================
echo.

:: 设置编码为UTF-8
chcp 65001 >nul

echo 🔧 正在部署生产环境API修复...
echo.

:: 检查关键文件
echo 📋 检查文件状态:
if exist "ai-ppt-generator.html" (
    echo ✅ 主应用文件存在
) else (
    echo ❌ 主应用文件缺失
    goto :error
)

if exist "vercel.json" (
    echo ✅ Vercel配置文件存在
) else (
    echo ❌ Vercel配置文件缺失
    goto :error
)

if exist "api\openai.js" (
    echo ✅ OpenAI API代理存在
) else (
    echo ❌ OpenAI API代理缺失
    goto :error
)

if exist "api\diagnostic.js" (
    echo ✅ 诊断API存在
) else (
    echo ❌ 诊断API缺失
    goto :error
)

echo.

:: 显示修复内容
echo 🎯 本次修复内容:
echo   ✅ 改进生产环境API调用逻辑，支持智能重试
echo   ✅ 添加多层后备策略，确保用户始终能看到内容
echo   ✅ 优化错误处理，404/500错误自动回退到演示数据
echo   ✅ 增加API状态检测，页面加载时自动检查服务可用性
echo   ✅ 改进用户体验，清晰的状态提示和错误说明
echo.

:: Git操作
echo 📤 提交更改到Git...
git add .
git commit -m "fix: 修复生产环境API调用问题，添加智能重试和后备策略，确保用户体验"

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git提交失败
    goto :error
)

echo 📤 推送到GitHub...
git push origin main

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git推送失败
    goto :error
)

echo.
echo ✅ 修复部署成功！
echo.

:: 显示验证步骤
echo ========================================
echo           🧪 验证修复效果
echo ========================================
echo.
echo 请按以下步骤验证修复是否成功:
echo.
echo 1. 等待Vercel部署完成 (通常1-3分钟)
echo.
echo 2. 访问您的应用: https://your-app.vercel.app/
echo.
echo 3. 检查API状态指示器:
echo    🟢 绿色 = AI服务正常，会生成真实内容
echo    🟡 黄色 = API可用但配置不完整
echo    🔴 红色 = API不可用，使用演示数据
echo.
echo 4. 测试生成功能:
echo    - 点击"给我一个示例"填充内容
echo    - 选择不同组件类型
echo    - 点击"生成预览"
echo    - 应该能看到内容，不会出现无法生成的情况
echo.
echo 5. 如果看到API错误提示:
echo    - 内容仍然会正常显示（使用演示数据）
echo    - 检查Vercel环境变量配置:
echo      * AZURE_OPENAI_API_KEY
echo      * AZURE_OPENAI_ENDPOINT
echo.
echo 6. 使用诊断工具进一步检查:
echo    访问: https://your-app.vercel.app/api-404-diagnosis.html
echo.
echo ========================================
echo            ⚙️ 环境变量配置
echo ========================================
echo.
echo 如果API状态显示配置不完整，请在Vercel项目设置中配置:
echo.
echo 变量名: AZURE_OPENAI_API_KEY
echo 值: 您的Azure OpenAI API密钥
echo.
echo 变量名: AZURE_OPENAI_ENDPOINT  
echo 值: https://your-resource-name.openai.azure.com
echo.
echo 配置完成后需要重新部署项目。
echo.
echo ========================================
echo             📊 关键改进
echo ========================================
echo.
echo ✅ 永不出错: 即使API完全失败，用户也能看到演示内容
echo ✅ 智能重试: 自动重试失败的API调用，提高成功率
echo ✅ 状态透明: 清晰显示当前使用的是AI生成还是演示数据
echo ✅ 用户友好: 不再弹出技术错误，而是显示友好提示
echo ✅ 便于调试: 详细的控制台日志，便于技术人员排查问题
echo.

goto :end

:error
echo.
echo ❌ 部署失败，请检查错误信息
echo.
pause
exit /b 1

:end
echo.
echo 🎉 部署完成！现在生产环境应该能正常工作了。
echo.
echo 按任意键退出...
pause >nul
