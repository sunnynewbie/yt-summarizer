// Controller logic 

import subscriptionPlan from "../../models/subscription_plan.js";
import { setAuditContext } from "../../utils/audit.js";

export async function getPlans(req, res) {

    try {
        var response = await subscriptionPlan.findAll({});
        setAuditContext(req, {
            action: 'plans.list',
            featureArea: 'plans',
            resourceType: 'subscription_plan',
            metadata: { count: response.length },
        });
        return res.status(200).json({
            success: true,
            message: 'Plans fetched successfully',
            data: response.map(j => j.toJSON())
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}

export async function getSinglePlan(req, res) {
    try {

        if (!req.params.id) {
            return res.status(403).json({ success: false, message: 'Plan id is required' });
        }

        var response = await subscriptionPlan.findByPk(req.params.id);
        if (!response) {
            return res.status(404).json({ success: false, message: 'Plan not found' });
        }
        setAuditContext(req, {
            action: 'plans.read',
            featureArea: 'plans',
            resourceType: 'subscription_plan',
            resourceId: String(response.id),
        });
        return res.status(200).json({ success: true, message: 'Plan fetched successfully', data: response.toJSON() });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }

}
export async function addPlan(req, res) {
    try {
        ///varify all values which are ther in subscription_plan table
        var { plan_name, video_limit, minute_limit, price } = req.body
        if (!plan_name || video_limit == null || minute_limit == null || price == null) {
            var msg = '';
            if (!plan_name) {
                msg += 'plan_name,'
            }
            if (!video_limit) {
                msg += 'video_limit,'
            }
            if (!minute_limit) {
                msg += 'minute_limit,'
            }
            if (!price) {
                msg += 'price,'
            }
            return res.status(403).json({ success: false, message: 'All fields are required to add plan' + msg });
        }
        var response = await subscriptionPlan.create({ plan_name, video_limit, minute_limit, price });
        setAuditContext(req, {
            action: 'plans.create',
            featureArea: 'plans',
            resourceType: 'subscription_plan',
            resourceId: String(response.id),
            actorUserId: req.user?.id,
            actorRole: req.user?.role,
            metadata: { plan_name, video_limit, minute_limit, price },
        });
        return res.status(201).json({ success: true, message: 'Plan added successfully', data: response.toJSON() });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}

export async function updatePlan(req, res) {
    try {
        //values can be null or  undefinded but need to be ignore while updating
        var { plan_name, video_limit, minute_limit, price } = req.body;
        const payload = Object.fromEntries(
            Object.entries({ plan_name, video_limit, minute_limit, price }).filter(([, value]) => value !== undefined)
        );
        if (Object.keys(payload).length === 0) {
            return res.status(400).json({ success: false, message: 'At least one field is required' });
        }
        const plan = await subscriptionPlan.findByPk(req.params.id);
        if (!plan) {
            return res.status(404).json({ success: false, message: 'Plan not found' });
        }
        await plan.update(payload);
        setAuditContext(req, {
            action: 'plans.update',
            featureArea: 'plans',
            resourceType: 'subscription_plan',
            resourceId: String(plan.id),
            actorUserId: req.user?.id,
            actorRole: req.user?.role,
            metadata: { updated_fields: Object.keys(payload).sort() },
        });
        return res.status(200).json({ success: true, message: 'Plan updated successfully', data: plan.toJSON() });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }

}

export async function deletePlan(req, res) {
    try {
        const plan = await subscriptionPlan.findByPk(req.params.id);
        if (!plan) {
            return res.status(404).json({ success: false, message: 'Plan not found' });
        }
        await plan.update({ is_active: false });
        setAuditContext(req, {
            action: 'plans.delete',
            featureArea: 'plans',
            resourceType: 'subscription_plan',
            resourceId: String(plan.id),
            actorUserId: req.user?.id,
            actorRole: req.user?.role,
            metadata: { soft_delete: true },
        });
        return res.status(200).json({ success: true, message: 'Plan deleted successfully' });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}

