#!/bin/bash

echo "🔍 Vercel 部署前检查清单"
echo "========================="

# 检查必要文件
echo "1. 检查必要文件..."
files=("vercel.json" "ai-ppt-generator.html" "api/openai.js" "api/vision.js" "api/hello.js" "api/check-env.js")

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file 存在"
    else
        echo "❌ $file 缺失"
    fi
done

echo ""
echo "2. 检查 vercel.json 格式..."
if grep -q '"version": 2' vercel.json && grep -q '"builds"' vercel.json; then
    echo "✅ vercel.json 使用正确的 v2 格式"
else
    echo "❌ vercel.json 格式可能有问题"
fi

echo ""
echo "3. 检查 API 文件导出格式..."
api_files=("api/openai.js" "api/vision.js" "api/hello.js" "api/check-env.js")

for file in "${api_files[@]}"; do
    if grep -q "module.exports" "$file"; then
        echo "✅ $file 使用正确的导出格式"
    else
        echo "⚠️  $file 可能使用了不兼容的导出格式"
    fi
done

echo ""
echo "4. 部署建议..."
echo "📋 在 Vercel 控制台中："
echo "   - 确保环境变量已设置"
echo "   - 选择正确的框架预设（Other 或 Static）"
echo "   - 构建命令留空"
echo "   - 输出目录留空"

echo ""
echo "5. 测试链接（部署后）..."
echo "🔗 主应用: https://your-app.vercel.app/"
echo "🔗 API 测试: https://your-app.vercel.app/api/hello"
echo "🔗 诊断页面: https://your-app.vercel.app/api-diagnosis.html"

echo ""
echo "✅ 检查完成！准备部署到 Vercel。"
