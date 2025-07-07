// Vercel Serverless Function for Vision API
// 处理图片文字识别请求

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
        // 从环境变量中获取API密钥和端点
        const apiKey = process.env.AZURE_OPENAI_API_KEY;
        const baseEndpoint = process.env.AZURE_OPENAI_ENDPOINT;

        if (!apiKey || !baseEndpoint) {
            return res.status(500).json({ error: 'API configuration missing' });
        }

        const { imageData, imageType } = req.body;

        if (!imageData) {
            return res.status(400).json({ error: 'Image data is required' });
        }

        // 构建完整的API端点URL（需要支持Vision的模型，如gpt-4o）
        const cleanEndpoint = baseEndpoint.replace(/\/$/, '');
        const fullEndpoint = `${cleanEndpoint}/openai/deployments/gpt-4o/chat/completions?api-version=2024-02-01`;

        const requestBody = {
            messages: [
                {
                    role: "system",
                    content: "你是一个专业的图片文字识别助手。请仔细识别图片中的所有文字内容，包括中文、英文、数字等。请保持原有的格式和结构，如果是表格请尽量保持表格格式。只返回识别出的文字内容，不要添加任何解释。"
                },
                {
                    role: "user",
                    content: [
                        {
                            type: "text",
                            text: "请识别这张图片中的所有文字内容："
                        },
                        {
                            type: "image_url",
                            image_url: {
                                url: imageData
                            }
                        }
                    ]
                }
            ],
            max_tokens: 1000,
            temperature: 0.1
        };

        console.log('发送Vision API请求到:', fullEndpoint);

        const response = await fetch(fullEndpoint, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'api-key': apiKey
            },
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            const errorText = await response.text();
            console.error('Azure OpenAI API error:', response.status, errorText);
            
            let errorMessage = 'Vision API调用失败';
            try {
                const errorData = JSON.parse(errorText);
                errorMessage = errorData.error?.message || errorMessage;
            } catch (e) {
                errorMessage = errorText || errorMessage;
            }
            
            return res.status(response.status).json({ 
                error: errorMessage,
                details: errorText 
            });
        }

        const data = await response.json();
        console.log('Azure OpenAI API response received');

        if (data.choices && data.choices[0] && data.choices[0].message) {
            const result = data.choices[0].message.content.trim();
            return res.status(200).json({ 
                result: result,
                usage: data.usage 
            });
        } else {
            console.error('Invalid API response format:', data);
            return res.status(500).json({ error: 'Invalid API response format' });
        }

    } catch (error) {
        console.error('Vision API handler error:', error);
        return res.status(500).json({ 
            error: 'Internal server error',
            message: error.message 
        });
    }
};
