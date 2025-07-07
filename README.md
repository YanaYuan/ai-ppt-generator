# AI PPT组件生成器 v5.0

🚀 **智能生成专业PPT组件，支持图片文字识别的现代化工具**

## ✨ 核心特性

### 🎯 智能组件生成
- **5种组件类型**：图标列表、简约列表、数据表格、柱状图表、优劣对比
- **AI驱动**：基于Azure OpenAI GPT-4o，智能理解用户需求
- **一键生成**：输入内容即可生成专业PPT组件

### 📷 图片文字识别
- **剪贴板支持**：直接从剪贴板读取图片
- **Vision API**：集成Azure OpenAI Vision能力
- **智能OCR**：准确识别中英文、数字、表格等内容

### 🌐 环境自适应
- **本地开发**：直接调用Azure OpenAI API，开发调试便捷
- **生产部署**：通过Vercel代理，安全稳定
- **自动检测**：无需手动配置，智能切换调用方式

### 🎨 现代化UI
- **响应式设计**：适配各种屏幕尺寸
- **直观操作**：简洁美观的用户界面
- **即时预览**：实时查看生成效果

## 🚀 快速开始

### 本地使用
1. 下载项目文件
2. 用浏览器打开 `ai-ppt-generator.html`
3. 开始使用所有功能！

### 在线体验
访问：[https://your-project.vercel.app](https://your-project.vercel.app)

## 📋 功能说明

### 组件类型

| 组件 | 适用场景 | 示例 |
|------|----------|------|
| 🔸 **图标列表** | 核心价值观、特色功能 | 公司价值观展示 |
| 📝 **简约列表** | 流程步骤、要点罗列 | 软件开发流程 |
| 📊 **数据表格** | 功能对比、数据统计 | 产品功能比较 |
| 📈 **柱状图表** | 数值展示、趋势分析 | 销售额统计 |
| ⚖️ **优劣对比** | 方案比较、利弊分析 | 传统vs现代方案 |

### 操作流程
1. **输入内容**：描述您要制作的PPT内容
2. **选择组件**：根据内容选择合适的组件类型
3. **生成预览**：AI自动生成专业的PPT组件
4. **图片识别**：可选择从图片中提取文字内容

## 🛠 技术架构

### 前端技术
- **HTML5/CSS3/JavaScript**：原生技术栈，兼容性好
- **Tailwind CSS**：现代化样式框架
- **D3.js**：数据可视化图表
- **FontAwesome**：图标库

### AI能力
- **Azure OpenAI GPT-4o**：智能内容生成
- **Vision API**：图片文字识别
- **智能Prompt**：优化的提示词工程

### 部署架构
- **Vercel**：无服务器部署平台
- **Edge Functions**：API代理和处理
- **CDN加速**：全球快速访问

## 📦 部署说明

### 环境变量配置
```bash
AZURE_OPENAI_API_KEY=your_api_key
AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com
```

### Vercel部署
1. Fork本仓库
2. 在Vercel中导入项目
3. 配置环境变量
4. 部署完成！

详细部署指南请参考：[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)

## 🔧 本地开发

### 开发环境
- 现代浏览器（Chrome/Edge/Firefox）
- 无需Node.js或构建工具
- 直接打开HTML文件即可

### 调试模式
- 打开浏览器开发者工具
- 查看Console输出
- 监控网络请求

## 🤝 贡献指南

### 问题反馈
- 通过 [Issues](https://github.com/yourusername/ai-ppt-generator/issues) 报告问题
- 提供详细的问题描述和复现步骤

### 功能建议
- 在 [Discussions](https://github.com/yourusername/ai-ppt-generator/discussions) 中提出建议
- 欢迎贡献新的组件类型和功能

### 代码贡献
1. Fork 项目
2. 创建功能分支
3. 提交代码
4. 发起 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 🙏 致谢

- **Azure OpenAI**：提供强大的AI能力
- **Vercel**：优秀的部署平台
- **开源社区**：各种优秀的前端库和工具

## 📞 联系方式

- 项目主页：[GitHub](https://github.com/yourusername/ai-ppt-generator)
- 在线演示：[Vercel](https://your-project.vercel.app)
- 问题反馈：[Issues](https://github.com/yourusername/ai-ppt-generator/issues)

---

⭐ 如果这个项目对您有帮助，请给我们一个 Star！
