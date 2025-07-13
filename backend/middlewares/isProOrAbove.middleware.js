export const isProOrAbove = async (req, res, next) => {
    try {
        const planName = req.userPlan?.plan_name;

        if (!planName) {
            return res.status(400).json({ error: 'Missing plan info. Add hasActivePlan middleware first.' });
        }

        // Allow only Pro or higher (you can add Enterprise, etc. later)
        if (planName !== 'Pro') {
            return res.status(403).json({ error: 'Pro-level access required.' });
        }

        next();
    } catch (err) {
        console.error('isProOrAbove error:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
};
