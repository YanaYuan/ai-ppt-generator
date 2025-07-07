@echo off
REM AI PPT组件生成器版本回滚脚本
echo AI PPT组件生成器 - 回滚到版本3.0
echo 正在从 backup_2025-07-06_version3 恢复文件...
echo.

copy "backup_2025-07-06_version3\ai-ppt-generator.html" .
copy "backup_2025-07-06_version3\core-value.html" .
copy "backup_2025-07-06_version3\ai-transform.html" .
copy "backup_2025-07-06_version3\table-component.html" .
copy "backup_2025-07-06_version3\chart-component.html" .
copy "backup_2025-07-06_version3\left-right-component.html" .
copy "backup_2025-07-06_version3\styles.css" .

echo.
echo 版本3.0恢复完成！
echo.
echo 版本3.0特色：
echo - 产品名称更新为"AI PPT组件生成器"
echo - 每个组件精选1个demo案例
echo - 优化的用户体验和界面设计
echo - 默认选择图标列表组件
echo.
pause
