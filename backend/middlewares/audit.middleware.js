import crypto from 'crypto';
import { recordAuditEvent } from '../utils/audit.js';

export function auditMiddleware(req, res, next) {
    req.requestId = req.get('x-request-id') || crypto.randomUUID();
    res.setHeader('x-request-id', req.requestId);

    const startedAt = Date.now();
    let auditQueued = false;

    const queueAudit = () => {
        if (auditQueued) {
            return;
        }

        auditQueued = true;
        setImmediate(() => {
            recordAuditEvent(req, res, startedAt).catch((error) => {
                console.error('Audit log write failed:', error);
            });
        });
    };

    res.on('finish', queueAudit);
    res.on('close', queueAudit);

    return next();
}
