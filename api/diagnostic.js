// 综合API测试端点 - 用于诊断Vercel部署问题
module.exports = async function handler(req, res) {
    // 设置CORS头
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    res.setHeader('Content-Type', 'application/json');

    if (req.method === 'OPTIONS') {
        res.status(200).end();
        return;
    }

    try {
        const diagnosticInfo = {
            success: true,
            timestamp: new Date().toISOString(),
            method: req.method,
            url: req.url,
            headers: req.headers,
            environment: {
                nodeVersion: process.version,
                platform: process.platform,
                vercelRegion: process.env.VERCEL_REGION || 'unknown',
                vercelUrl: process.env.VERCEL_URL || 'unknown'
            },
            environmentVariables: {
                hasAzureApiKey: !!process.env.AZURE_OPENAI_API_KEY,
                hasAzureEndpoint: !!process.env.AZURE_OPENAI_ENDPOINT,
                azureApiKeyLength: process.env.AZURE_OPENAI_API_KEY ? process.env.AZURE_OPENAI_API_KEY.length : 0,
                azureEndpointHost: process.env.AZURE_OPENAI_ENDPOINT ? new URL(process.env.AZURE_OPENAI_ENDPOINT).hostname : 'not-set'
            },
            apiTests: {
                basicFunction: 'working',
                cors: 'enabled',
                jsonResponse: 'working'
            }
        };

        // 如果是GET请求，返回诊断信息
        if (req.method === 'GET') {
            res.status(200).json(diagnosticInfo);
            return;
        }

        // 如果是POST请求，额外测试请求体解析
        if (req.method === 'POST') {
            diagnosticInfo.requestBody = req.body;
            diagnosticInfo.apiTests.postRequest = 'working';
            diagnosticInfo.apiTests.bodyParsing = req.body ? 'working' : 'no-body';
        }

        res.status(200).json(diagnosticInfo);

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error.message,
            stack: error.stack,
            timestamp: new Date().toISOString()
        });
    }
};
