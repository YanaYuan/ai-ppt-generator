# 🔧 Vercel API 404 问题解决指南

## 问题描述
在 Vercel 生产环境中，API 端点 `/api/openai` 和 `/api/vision` 返回 404 错误，但本地开发环境正常。

## 已完成的修复

### 1. ✅ 修复 index.html 空文件问题
- 问题：`index.html` 文件为空，可能导致路由问题
- 解决：创建了包含自动重定向的 `index.html`

### 2. ✅ 优化 vercel.json 配置
- 更新了 builds 配置，使用 `api/**/*.js` 确保所有 API 文件被识别
- 改进了 routes 配置，确保正确的路由规则

### 3. ✅ 创建诊断工具
- `api/diagnostic.js`: 综合 API 测试端点
- `api-404-diagnosis.html`: 专项诊断页面

### 4. ✅ 验证 API 文件格式
- 确认所有 API 文件使用正确的 `module.exports` 格式
- 验证异步函数签名正确

## 当前配置状态

### vercel.json 配置
```json
{
  "version": 2,
  "builds": [
    {
      "src": "*.html",
      "use": "@vercel/static"
    },
    {
      "src": "api/**/*.js",
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
      "dest": "/index.html"
    },
    {
      "src": "/(.*)",
      "dest": "/$1"
    }
  ]
}
```

### API 文件结构
```
api/
├── openai.js          # 主要的 OpenAI API 代理
├── vision.js          # 图像识别 API 代理
├── hello.js           # 简单测试端点
├── diagnostic.js      # 综合诊断端点
└── check-env.js       # 环境变量检查
```

## 部署步骤

### 1. 推送到 GitHub
```bash
git add .
git commit -m "fix: 修复 Vercel API 404 问题 - 优化配置和诊断工具"
git push origin main
```

### 2. 在 Vercel 中配置环境变量
必须设置以下环境变量：
- `AZURE_OPENAI_API_KEY`: Azure OpenAI API 密钥
- `AZURE_OPENAI_ENDPOINT`: Azure OpenAI 端点 URL

### 3. 部署后验证步骤

#### 使用诊断工具
1. 访问 `https://your-app.vercel.app/api-404-diagnosis.html`
2. 点击 "🚀 测试所有API端点"
3. 检查每个 API 端点的状态

#### 手动测试关键端点
1. `https://your-app.vercel.app/api/hello` - 应返回成功消息
2. `https://your-app.vercel.app/api/diagnostic` - 应返回环境诊断信息
3. `https://your-app.vercel.app/api/openai` - 应返回 405 (Method Not Allowed) 或环境配置错误

#### 检查生产环境响应
```bash
curl -X GET https://your-app.vercel.app/api/hello
curl -X GET https://your-app.vercel.app/api/diagnostic
```

## 可能的问题和解决方案

### 问题 1: API 文件未被识别为 Serverless Function
**症状**: 所有 `/api/*` 端点都返回 404
**解决方案**:
1. 检查 `vercel.json` 中的 builds 配置
2. 确保 API 文件在 `api/` 目录下
3. 验证文件扩展名为 `.js`

### 问题 2: 路由配置错误
**症状**: 特定端点返回 404，但其他正常
**解决方案**:
1. 检查 `vercel.json` 中的 routes 配置
2. 确保路由规则顺序正确

### 问题 3: 环境变量未配置
**症状**: API 端点可访问，但返回配置错误
**解决方案**:
1. 在 Vercel 项目设置中配置环境变量
2. 重新部署项目

### 问题 4: API 文件语法错误
**症状**: 特定 API 端点返回 500 错误
**解决方案**:
1. 检查 Vercel 函数日志
2. 验证 `module.exports` 格式
3. 检查异步函数语法

## 调试命令

### 本地测试
```bash
# 启动本地服务器
npx vercel dev

# 测试 API 端点
curl http://localhost:3000/api/hello
curl http://localhost:3000/api/diagnostic
```

### 生产环境检查
```bash
# 检查部署状态
npx vercel ls

# 查看函数日志
npx vercel logs [deployment-url]

# 检查域名配置
npx vercel domains ls
```

## 文件清单

### 核心文件
- [x] `index.html` - 入口页面（已修复）
- [x] `ai-ppt-generator.html` - 主应用
- [x] `vercel.json` - Vercel 配置（已优化）
- [x] `api/openai.js` - OpenAI API 代理
- [x] `api/vision.js` - Vision API 代理
- [x] `api/hello.js` - 简单测试端点
- [x] `api/diagnostic.js` - 诊断端点（新增）

### 诊断工具
- [x] `api-404-diagnosis.html` - API 404 专项诊断（新增）
- [x] `vercel-live-diagnosis.html` - 实时诊断工具

### 文档
- [x] `README.md` - 项目说明
- [x] `DEPLOYMENT_GUIDE.md` - 部署指南
- [x] `VERCEL_API_TROUBLESHOOTING.md` - API 故障排除指南

## 下一步行动

1. **立即行动**: 将当前修复推送到 GitHub 并重新部署
2. **验证**: 使用 `api-404-diagnosis.html` 工具验证修复效果
3. **监控**: 使用诊断工具持续监控 API 状态
4. **环境变量**: 确保在 Vercel 后台正确配置所有环境变量

## 成功标准

- [ ] `https://your-app.vercel.app/api/hello` 返回成功响应
- [ ] `https://your-app.vercel.app/api/diagnostic` 返回环境信息
- [ ] `https://your-app.vercel.app/api/openai` 不再返回 404（可能返回 405 或配置错误，这是正常的）
- [ ] 主应用能够成功调用 API 端点进行 PPT 生成
- [ ] 图像识别功能在生产环境正常工作
