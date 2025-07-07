@echo off
echo ============================================
echo AI PPT组件生成器 - 回滚到V5稳定版本
echo ============================================
echo.
echo 此操作将回滚到 2025-07-07 V5 稳定版本
echo.
set /p confirm="确认要回滚吗? (y/N): "
if /i "%confirm%" NEQ "y" (
    echo 已取消回滚操作
    pause
    exit /b 0
)

echo.
echo 正在回滚到V5稳定版本...

:: 备份当前版本
set backup_name=backup_before_rollback_%date:~0,4%-%date:~5,2%-%date:~8,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
set backup_name=%backup_name: =0%
mkdir "%backup_name%" 2>nul
copy "ai-ppt-generator.html" "%backup_name%\" 2>nul
copy "table-component.html" "%backup_name%\" 2>nul
echo 当前版本已备份到: %backup_name%

:: 执行回滚
copy "backup_2025-07-07_v5_stable\ai-ppt-generator.html" "." /Y
copy "backup_2025-07-07_v5_stable\table-component.html" "." /Y
xcopy "backup_2025-07-07_v5_stable\api" "api\" /E /Y 2>nul
copy "backup_2025-07-07_v5_stable\package.json" "." /Y 2>nul
copy "backup_2025-07-07_v5_stable\vercel.json" "." /Y 2>nul

echo.
echo ============================================
echo 回滚完成！
echo ============================================
echo.
echo 已成功回滚到V5稳定版本 (2025-07-07)
echo.
echo 主要特性:
echo - 从剪贴板图片识别文字功能
echo - 示例按钮在标题行
echo - 循环选择demo案例
echo - 优化的表格重要信息显示
echo.
echo 当前版本备份位置: %backup_name%
echo.
pause
