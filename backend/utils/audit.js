import auditLogs from '../models/audit_logs.js';

function normalizeRoutePath(req) {
    if (req.baseUrl && req.route?.path) {
        return `${req.baseUrl}${req.route.path}`;
    }

    return req.baseUrl || req.path || req.originalUrl || '/';
}

function getFeatureArea(routePath) {
    const [firstSegment] = String(routePath || '')
        .split('?')[0]
        .split('/')
        .filter(Boolean);

    return firstSegment || 'root';
}

function getClientIp(req) {
    const forwardedFor = req.headers['x-forwarded-for'];
    if (typeof forwardedFor === 'string' && forwardedFor.trim()) {
        return forwardedFor.split(',')[0].trim();
    }

    return req.ip || req.socket?.remoteAddress || null;
}

function sanitizeMetadata(value, depth = 0) {
    if (depth > 2 || value == null) {
        return undefined;
    }

    if (Array.isArray(value)) {
        return value
            .slice(0, 20)
            .map((item) => sanitizeMetadata(item, depth + 1))
            .filter((item) => item !== undefined);
    }

    if (typeof value === 'object') {
        return Object.fromEntries(
            Object.entries(value)
                .slice(0, 20)
                .map(([key, item]) => [key, sanitizeMetadata(item, depth + 1)])
                .filter(([, item]) => item !== undefined)
        );
    }

    if (typeof value === 'string') {
        return value.length > 300 ? `${value.slice(0, 300)}...` : value;
    }

    if (['number', 'boolean'].includes(typeof value)) {
        return value;
    }

    return undefined;
}

function defaultActionFor(req, routePath) {
    const featureArea = getFeatureArea(routePath);
    const method = String(req.method || 'GET').toLowerCase();
    return `${featureArea}.${method}`;
}

export function setAuditContext(req, context = {}) {
    req.auditContext = {
        ...(req.auditContext || {}),
        ...context,
        metadata: {
            ...((req.auditContext && req.auditContext.metadata) || {}),
            ...((context && context.metadata) || {}),
        },
    };
}

export async function recordAuditEvent(req, res, startedAt) {
    const routePath = normalizeRoutePath(req);

    if (routePath === '/health' || routePath.startsWith('/docs')) {
        return;
    }

    const context = req.auditContext || {};
    const durationMs = Number.isFinite(startedAt) ? Math.max(0, Date.now() - startedAt) : null;
    const statusCode = res.statusCode || 500;
    const outcome = statusCode >= 500 ? 'error' : statusCode >= 400 ? 'rejected' : 'success';
    const actor = req.user || {};

    const metadata = sanitizeMetadata({
        authenticated: Boolean(actor.id),
        body_keys: req.body && typeof req.body === 'object' ? Object.keys(req.body).sort() : [],
        param_keys: req.params ? Object.keys(req.params).sort() : [],
        query_keys: req.query ? Object.keys(req.query).sort() : [],
        origin: req.headers.origin || null,
        referer: req.headers.referer || null,
        client_platform: req.headers['x-client-platform'] || null,
        ...context.metadata,
    }) || {};

    await auditLogs.create({
        request_id: req.requestId || null,
        actor_user_id: context.actorUserId || actor.id || null,
        actor_role: context.actorRole || actor.role || null,
        action: context.action || defaultActionFor(req, routePath),
        feature_area: context.featureArea || getFeatureArea(routePath),
        resource_type: context.resourceType || null,
        resource_id: context.resourceId || null,
        http_method: req.method,
        route_path: routePath,
        status_code: statusCode,
        outcome,
        ip_address: getClientIp(req),
        user_agent: req.get('user-agent') || null,
        client_origin: req.get('origin') || null,
        duration_ms: durationMs,
        metadata,
    });
}
