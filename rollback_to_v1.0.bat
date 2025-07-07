@echo off
REM AI PPT生成器版本回滚脚本
REM 回滚到 2025-07-06 v1.0-stable 版本

echo 正在回滚到 2025年7月6日 v1.0-stable 版本...
echo.

REM 备份当前版本
if not exist "current_backup" mkdir current_backup
copy *.html current_backup\ >nul 2>&1
copy *.css current_backup\ >nul 2>&1
echo 当前版本已备份到 current_backup 目录

REM 复制备份版本文件
copy backup_2025-07-06_version1\*.html .\ >nul 2>&1
copy backup_2025-07-06_version1\*.css .\ >nul 2>&1

echo.
echo 回滚完成！
echo.
echo 已恢复的文件：
echo - ai-ppt-generator.html (主产品页面)
echo - core-value.html (图标列表组件)
echo - ai-transform.html (简约列表组件)  
echo - table-component.html (数据表格组件)
echo - chart-component.html (柱状图表组件)
echo - left-right-component.html (优劣对比组件)
echo - styles.css (统一样式文件)
echo.
echo 版本特性：
echo ✓ 智能重要信息标识系统
echo ✓ 数值最大柱子橙色高亮
echo ✓ 智能总结结论生成
echo ✓ 统一视觉风格
echo ✓ 文字对齐优化
echo.
echo 请打开 ai-ppt-generator.html 开始使用！
pause
