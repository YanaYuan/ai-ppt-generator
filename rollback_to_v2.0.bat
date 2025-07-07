@echo off
echo ========================================
echo AI PPT生成器 - 回滚到版本2.0
echo ========================================
echo.

echo 正在备份当前版本...
if not exist "backup_current" mkdir backup_current
copy *.html backup_current\ >nul 2>&1
copy *.css backup_current\ >nul 2>&1
copy *.bat backup_current\ >nul 2>&1
echo 当前版本已备份到 backup_current 目录

echo.
echo 正在回滚到版本2.0...
copy backup_2025-07-06_version2\*.html . >nul 2>&1
copy backup_2025-07-06_version2\*.css . >nul 2>&1
echo 文件已恢复

echo.
echo ========================================
echo 回滚完成！
echo ========================================
echo.
echo 版本2.0特性:
echo - 图标列表组件支持动态项数(2-6项)
echo - 简约列表组件移除预设场景，动态项数
echo - 柱状图表组件智能单位标识(绝对数值)
echo - 全面智能化内容生成，无硬编码限制
echo.
echo 详细说明请查看: backup_2025-07-06_version2\VERSION_INFO_v2.0.md
echo.
pause
