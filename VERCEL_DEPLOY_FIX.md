# 🚨 Vercel 部署错误修复指南

## 当前错误
```
Function Runtimes must have a valid version, for example 'now-php@1.0.0'
```

## 修复方案

### 1. 更新 vercel.json 配置
已将配置改为标准的 Vercel v2 格式：

```json
{
  "version": 2,
  "builds": [
    {
      "src": "*.html",
      "use": "@vercel/static"
    },
    {
      "src": "api/*.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api/$1"
    },
    {
      "src": "/",
      "dest": "/ai-ppt-generator.html"
    }
  ]
}
```

### 2. 确保 API 文件结构正确

您的 API 文件应该在以下位置：
- `api/openai.js`
- `api/vision.js`
- `api/hello.js`
- `api/check-env.js`

### 3. 部署步骤

1. **保存所有更改**
2. **上传到 GitHub**（如果使用 Git 集成）
3. **在 Vercel 控制台手动重新部署**

### 4. 环境变量设置

在 Vercel 项目设置中添加：
- `AZURE_OPENAI_API_KEY`: 您的 Azure OpenAI API 密钥
- `AZURE_OPENAI_ENDPOINT`: 您的 Azure OpenAI 端点

### 5. 验证部署

部署成功后，测试以下 URL：
- 主应用：`https://your-app.vercel.app/`
- API 测试：`https://your-app.vercel.app/api/hello`
- 诊断页面：`https://your-app.vercel.app/api-diagnosis.html`

## 常见问题

### Q: 为什么会出现 Runtime 错误？
A: 之前的配置使用了不兼容的新语法，现在改为标准的 Vercel v2 配置。

### Q: 如何确认部署成功？
A: 在 Vercel 控制台的 "Functions" 标签页应该能看到您的 API 函数。

### Q: 如果还是失败怎么办？
A: 检查 Vercel 控制台的构建日志，查看具体的错误信息。

## 下一步行动

1. 提交这些更改到 GitHub
2. 触发 Vercel 重新部署
3. 使用诊断工具测试 API 连通性

---
*修复时间：2025-07-07*
