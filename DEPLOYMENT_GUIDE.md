# GitHub上传和Vercel部署指南

## 准备工作

### 1. 环境检测功能已集成
- ✅ 本地环境：直接调用Azure OpenAI API
- ✅ 生产环境：通过Vercel代理调用API
- ✅ 自动环境检测，无需手动配置

### 2. 文件结构检查
```
ai-ppt-generator/
├── ai-ppt-generator.html     # 主应用文件
├── table-component.html      # 表格组件
├── package.json             # 项目配置
├── vercel.json              # Vercel部署配置
├── .env.example             # 环境变量模板
├── api/
│   ├── openai.js           # 主API代理
│   └── vision.js           # 图片识别API代理
└── README.md               # 项目说明
```

## GitHub上传步骤

### 1. 初始化Git仓库
```bash
cd c:\Users\yinyuan\Demo10
git init
git add .
git commit -m "Initial commit: AI PPT Generator v5.0"
```

### 2. 创建GitHub仓库
1. 访问 https://github.com/new
2. 仓库名称：`ai-ppt-generator`
3. 描述：`AI PPT组件生成器 - 智能生成专业PPT组件`
4. 设为公开仓库
5. 不要初始化README（因为我们已经有了）

### 3. 连接并推送到GitHub
```bash
git remote add origin https://github.com/你的用户名/ai-ppt-generator.git
git branch -M main
git push -u origin main
```

## Vercel部署步骤

### 1. 导入GitHub仓库
1. 访问 https://vercel.com
2. 点击"New Project"
3. 选择从GitHub导入
4. 选择刚创建的`ai-ppt-generator`仓库

### 2. 部署配置
- **Framework Preset**: Other
- **Root Directory**: ./
- **Build Command**: 留空
- **Output Directory**: ./
- **Install Command**: npm install

### 3. 环境变量配置
在Vercel项目设置中添加以下环境变量：

```
AZURE_OPENAI_API_KEY = af60f8ec72694fc8bbb785f492ae9a02
AZURE_OPENAI_ENDPOINT = https://hanc04-openai-sweden-central.openai.azure.com
```

### 4. 部署
点击"Deploy"按钮开始部署

## 验证部署

### 1. 本地测试
```bash
# 打开本地文件
file:///c:/Users/yinyuan/Demo10/ai-ppt-generator.html
```
- ✅ 应该直接调用Azure OpenAI API
- ✅ 图片识别功能正常工作
- ✅ 所有组件生成功能正常

### 2. 生产环境测试
访问Vercel分配的域名（如：https://your-project.vercel.app）
- ✅ 通过Vercel代理调用API
- ✅ 图片识别通过代理工作
- ✅ 所有功能与本地一致

## 功能特性

### 核心功能
1. **智能文本生成**：支持5种PPT组件类型
2. **图片文字识别**：集成Azure OpenAI Vision API
3. **环境自适应**：本地/生产环境自动切换API调用方式
4. **示例循环**：按顺序提供demo案例

### 组件类型
1. **图标列表** - 展示核心价值观等要点
2. **简约列表** - 流程步骤展示
3. **数据表格** - 结构化数据对比
4. **柱状图表** - 数据可视化展示
5. **优劣对比** - 左右对比分析

### 技术特色
- **零配置部署**：环境自动检测
- **API容错机制**：失败时回退到模拟数据
- **响应式设计**：适配各种屏幕尺寸
- **现代化UI**：简洁美观的用户界面

## 故障排除

### 常见问题
1. **API调用失败**
   - 检查环境变量配置
   - 确认Azure OpenAI资源状态
   - 查看Vercel函数日志

2. **图片识别不工作**
   - 确保部署了gpt-4o模型
   - 检查图片大小限制
   - 验证Vision API权限

3. **本地环境问题**
   - 确保网络连通性
   - 检查浏览器兼容性
   - 清除浏览器缓存

### 日志调试
- 本地：浏览器开发者工具Console
- 生产：Vercel Functions面板查看日志

## 项目状态
- ✅ V5.0 功能完整
- ✅ 本地开发友好
- ✅ 生产部署就绪
- ✅ 环境自适应
- ✅ 错误处理完善
