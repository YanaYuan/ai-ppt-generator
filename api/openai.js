// Vercel Serverless Function
// 将此文件放在 api/openai.js 目录下

module.exports = async function handler(req, res) {
    // 设置CORS头
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
        res.status(200).end();
        return;
    }

    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Method not allowed' });
    }

    try {
        // 优先用环境变量，否则本地用硬编码
        let apiKey = process.env.AZURE_OPENAI_API_KEY;
        let baseEndpoint = process.env.AZURE_OPENAI_ENDPOINT;

        // 本地开发时自动填充（仅本地可见，生产环境不要上传此密钥）
        if (!apiKey || !baseEndpoint) {
            // 本地调试用的占位符配置 - 请替换为您的实际配置
            apiKey = 'your-azure-openai-api-key-here'; 
            baseEndpoint = 'https://your-resource-name.openai.azure.com'; 
        }

        if (!apiKey || !baseEndpoint) {
            return res.status(500).json({ error: 'API configuration missing' });
        }

        // 提取请求数据
        const { userInput, componentType, prompt } = req.body;

        if (!prompt) {
            return res.status(400).json({ error: 'Prompt is required' });
        }

        // 构建完整的API端点URL
        const cleanEndpoint = baseEndpoint.replace(/\/$/, '');
        
        // 常见的部署名称和API版本组合
        const deploymentConfigs = [
            { deployment: 'gpt-4o', apiVersion: '2024-02-01' },
            { deployment: 'gpt-4o', apiVersion: '2023-12-01-preview' },
            { deployment: 'gpt-4', apiVersion: '2024-02-01' },
            { deployment: 'gpt-35-turbo', apiVersion: '2024-02-01' },
            { deployment: 'gpt-4', apiVersion: '2023-12-01-preview' },
            { deployment: 'gpt-35-turbo', apiVersion: '2023-12-01-preview' }
        ];

        // 构建请求体
        const requestBody = {
            messages: [
                {
                    role: "system",
                    content: "你是一个专业的PPT内容生成助手，擅长根据用户输入生成结构化的演示文稿内容。请始终返回有效的JSON格式数据，确保内容专业、准确、有条理。不要包含任何markdown格式或其他装饰文字，只返回纯JSON。"
                },
                {
                    role: "user",
                    content: prompt
                }
            ],
            max_tokens: 1500,
            temperature: 0.7
        };

        let lastError = null;
        
        // 尝试不同的配置组合
        for (const config of deploymentConfigs) {
            const fullEndpoint = `${cleanEndpoint}/openai/deployments/${config.deployment}/chat/completions?api-version=${config.apiVersion}`;
            
            console.log(`尝试配置: ${config.deployment} with API版本 ${config.apiVersion}`);
            
            try {
                const response = await fetch(fullEndpoint, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'api-key': apiKey
                    },
                    body: JSON.stringify(requestBody)
                });

                if (response.ok) {
                    const data = await response.json();
                    console.log(`✅ 成功使用配置: ${config.deployment} - ${config.apiVersion}`);
                    
                    // 解析AI响应
                    if (data.choices && data.choices[0] && data.choices[0].message) {
                        const aiResponse = data.choices[0].message.content;
                        
                        try {
                            // 清理响应内容，移除可能的markdown标记
                            let cleanResponse = aiResponse.trim();
                            if (cleanResponse.startsWith('```json')) {
                                cleanResponse = cleanResponse.replace(/^```json\s*/i, '').replace(/\s*```$/, '');
                            } else if (cleanResponse.startsWith('```')) {
                                cleanResponse = cleanResponse.replace(/^```\s*/, '').replace(/\s*```$/, '');
                            }
                            
                            const jsonData = JSON.parse(cleanResponse);
                            return res.status(200).json(jsonData);
                        } catch (parseError) {
                            console.error('解析AI响应失败:', parseError);
                            return res.status(500).json({ 
                                error: 'Failed to parse AI response',
                                rawResponse: aiResponse 
                            });
                        }
                    } else {
                        return res.status(500).json({ error: 'Invalid API response format' });
                    }
                } else {
                    const errorData = await response.json();
                    console.log(`❌ 配置失败: ${config.deployment} - ${response.status}`);
                    lastError = {
                        config,
                        status: response.status,
                        statusText: response.statusText,
                        data: errorData,
                        endpoint: fullEndpoint
                    };
                }
            } catch (error) {
                console.log(`❌ 配置异常: ${config.deployment} - ${error.message}`);
                lastError = {
                    config,
                    error: error.message,
                    endpoint: fullEndpoint
                };
            }
        }
        
        // 如果所有配置都失败，返回最后一个错误
        console.error('所有配置都失败了:', lastError);
        return res.status(lastError.status || 500).json({
            error: '所有部署配置都失败',
            lastError: lastError,
            suggestion: '请检查Azure OpenAI资源中的实际部署名称',
            testedConfigs: deploymentConfigs
        });
    } catch (error) {
        console.error('API调用异常:', {
            error: error.message,
            stack: error.stack,
            endpoint: `${baseEndpoint}/openai/deployments/gpt-4o/chat/completions`
        });
        res.status(500).json({ 
            error: 'Internal server error',
            message: error.message,
            details: '请检查API端点和密钥配置'
        });
    }
};
