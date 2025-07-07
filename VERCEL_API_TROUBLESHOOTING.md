# Vercel 部署 API 404 问题解决指南

## 问题描述
在 Vercel 生产环境中，访问 `/api/openai` 时返回 404 错误："The page could not be found"。

## 诊断步骤

### 1. 使用诊断页面
访问部署的诊断页面来测试 API 连通性：
- 本地：`http://localhost:3000/api-diagnosis.html`
- 生产：`https://your-app.vercel.app/api-diagnosis.html`

### 2. 检查 Vercel 部署日志
1. 登录 Vercel 控制台
2. 选择您的项目
3. 查看 "Functions" 标签页
4. 检查是否有 `api/openai.js` 和 `api/vision.js` 函数
5. 查看部署日志中是否有错误

### 3. 检查文件结构
确保项目根目录有以下文件：
```
├── api/
│   ├── openai.js
│   ├── vision.js
│   ├── hello.js
│   └── check-env.js
├── vercel.json
└── ai-ppt-generator.html
```

### 4. 检查 vercel.json 配置
确保 `vercel.json` 配置正确：
```json
{
  "version": 2,
  "functions": {
    "api/**/*.js": {
      "runtime": "nodejs18.x"
    }
  },
  "rewrites": [
    {
      "source": "/",
      "destination": "/ai-ppt-generator.html"
    }
  ]
}
```

### 5. 检查环境变量
在 Vercel 项目设置中配置以下环境变量：
- `AZURE_OPENAI_API_KEY`: 您的 Azure OpenAI API 密钥
- `AZURE_OPENAI_ENDPOINT`: 您的 Azure OpenAI 端点 URL

### 6. 常见解决方案

#### 方案 1: 重新部署
```bash
# 1. 确保所有文件都已提交
git add .
git commit -m "Fix API deployment"
git push origin main

# 2. 在 Vercel 控制台手动触发重新部署
```

#### 方案 2: 检查 API 文件格式
确保 `api/openai.js` 使用正确的 ES6 导出格式：
```javascript
export default async function handler(req, res) {
    // API 逻辑
}
```

#### 方案 3: 清理缓存
1. 在 Vercel 控制台中，进入项目设置
2. 选择 "General" 标签
3. 找到 "Build & Development Settings"
4. 清除构建缓存并重新部署

#### 方案 4: 检查域名配置
确保访问的是正确的域名：
- 使用 `.vercel.app` 域名进行测试
- 确保自定义域名（如果有）正确配置

### 7. 测试步骤

1. **基础连通性测试**
   ```bash
   curl -X GET https://your-app.vercel.app/api/hello
   ```

2. **OPTIONS 请求测试**
   ```bash
   curl -X OPTIONS https://your-app.vercel.app/api/openai
   ```

3. **完整 API 测试**
   ```bash
   curl -X POST https://your-app.vercel.app/api/openai \
     -H "Content-Type: application/json" \
     -d '{"userInput":"测试","componentType":"list","prompt":"生成测试列表"}'
   ```

### 8. 如果问题仍然存在

1. **检查 Vercel 函数限制**
   - 确保函数大小不超过 50MB
   - 检查执行时间是否超过限制

2. **查看 Vercel 日志**
   - 在 Vercel 控制台中查看实时日志
   - 检查是否有运行时错误

3. **本地测试**
   ```bash
   # 安装 Vercel CLI
   npm i -g vercel
   
   # 本地运行
   vercel dev
   ```

4. **联系支持**
   - 如果以上步骤都无效，请联系 Vercel 支持
   - 提供详细的错误日志和配置信息

## 常见错误码及解决方案

- **404**: API 函数未找到 → 检查文件路径和 vercel.json 配置
- **405**: 方法不允许 → 检查 HTTP 方法是否正确
- **500**: 服务器错误 → 检查环境变量和 API 逻辑
- **CORS**: 跨域错误 → 检查 CORS 头设置

## 成功部署的标志

1. 在 Vercel 控制台的 "Functions" 标签页能看到 API 函数
2. 诊断页面的所有测试都通过
3. 主应用能正常生成 PPT 组件
4. 没有 404 或 500 错误

## 最新更新

- 2024-01-XX: 更新了 vercel.json 配置格式
- 2024-01-XX: 添加了 API 诊断页面
- 2024-01-XX: 修复了 CORS 配置问题
