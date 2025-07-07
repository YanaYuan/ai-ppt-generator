// 简单的API端点测试 - 验证Vercel部署
module.exports = (req, res) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    res.setHeader('Content-Type', 'application/json');

    if (req.method === 'OPTIONS') {
        return res.status(200).end();
    }

    return res.status(200).json({
        status: 'success',
        message: 'API is working correctly',
        timestamp: new Date().toISOString(),
        method: req.method,
        url: req.url,
        vercel: {
            region: process.env.VERCEL_REGION || 'unknown',
            url: process.env.VERCEL_URL || 'unknown'
        }
    });
};
