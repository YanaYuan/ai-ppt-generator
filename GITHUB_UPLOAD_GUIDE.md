# 手动上传到GitHub指南

## 📋 准备工作

### 1. 确认核心文件清单
确保以下关键文件已准备好上传：

**核心文件：**
- `ai-ppt-generator.html` - 主应用文件（已修复语法错误）
- `api/openai.js` - API代理文件
- `api/test-env.js` - 环境变量测试文件
- `vercel.json` - Vercel部署配置
- `package.json` - 项目配置
- `.gitignore` - Git忽略文件配置

**文档文件：**
- `README.md` - 项目说明
- `DEPLOY.md` - 部署指南
- `SECURITY_REPORT.md` - 安全报告

### 2. 清理不必要的文件
以下文件建议不上传到GitHub（可以本地保留）：
- `backup_*` 文件夹
- `test-*.html` 测试文件
- `*-simple.html` 简化版文件
- `debug-*.html` 调试文件

## 🚀 上传步骤

### 方法一：通过GitHub Web界面上传

1. **创建新仓库**
   - 访问 https://github.com
   - 点击右上角 "+" → "New repository"
   - 仓库名称：`ai-ppt-generator`
   - 描述：`AI PPT组件生成器 - 智能生成PPT组件的Web应用`
   - 选择 Public 或 Private
   - 勾选 "Add a README file"
   - 点击 "Create repository"

2. **上传文件**
   - 在新建的仓库页面，点击 "uploading an existing file"
   - 将以下文件拖拽到页面：
     ```
     ai-ppt-generator.html
     vercel.json
     package.json
     .gitignore
     README.md
     DEPLOY.md
     SECURITY_REPORT.md
     ```
   - 创建 api 文件夹，上传：
     ```
     api/openai.js
     api/test-env.js
     ```

3. **提交更改**
   - 在页面底部填写提交信息：
     ```
     Title: 初始版本 - AI PPT组件生成器
     Description: 
     - 修复了主文件语法错误
     - 完善了API安全代理
     - 准备好Vercel部署
     ```
   - 点击 "Commit changes"

### 方法二：使用Git命令行（如果已安装Git）

```bash
# 1. 初始化Git仓库
git init

# 2. 添加远程仓库（替换为你的GitHub仓库URL）
git remote add origin https://github.com/你的用户名/ai-ppt-generator.git

# 3. 添加核心文件
git add ai-ppt-generator.html
git add api/openai.js
git add api/test-env.js
git add vercel.json
git add package.json
git add .gitignore
git add README.md
git add DEPLOY.md
git add SECURITY_REPORT.md

# 4. 提交更改
git commit -m "初始版本 - AI PPT组件生成器

- 修复了主文件语法错误
- 完善了API安全代理  
- 准备好Vercel部署"

# 5. 推送到GitHub
git push -u origin main
```

## 🔧 连接Vercel

上传到GitHub后，连接Vercel：

1. **导入GitHub仓库**
   - 访问 https://vercel.com
   - 点击 "New Project"
   - 选择从GitHub导入
   - 找到你的 `ai-ppt-generator` 仓库
   - 点击 "Import"

2. **配置环境变量**
   - 在Vercel项目设置中，添加环境变量：
     ```
     AZURE_OPENAI_API_KEY=af60f8ec72694fc8bbb785f492ae9a02
     AZURE_OPENAI_ENDPOINT=https://hanc04-openai-sweden-central.openai.azure.com
     ```

3. **部署**
   - Vercel会自动部署
   - 部署完成后测试功能

## ✅ 验证清单

部署完成后，请验证：

- [ ] 主页面可以正常访问
- [ ] 所有按钮可以点击
- [ ] 可以选择不同组件
- [ ] 输入内容后可以生成预览
- [ ] 访问 `/api/test-env` 可以看到环境变量状态
- [ ] 生成的内容是基于用户输入，而不是模板数据

## 🚨 重要提醒

1. **安全性**：确保API密钥只在Vercel环境变量中配置，不要提交到GitHub
2. **测试**：部署后先测试API连接是否正常
3. **监控**：关注Vercel的Function日志，查看是否有错误

## 📞 如有问题

如果遇到问题，可以：
1. 检查Vercel部署日志
2. 查看浏览器控制台错误
3. 访问 `/api/test-env` 检查环境变量
4. 查看Vercel Function日志
