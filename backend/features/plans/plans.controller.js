// Controller logic 

import subscriptionPlan from "../../models/subscription_plan.js";

export async function getPlans(req, res) {

    try {
        var response = await subscriptionPlan.findAll({});
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
        if (!plan_name || !video_limit || !minute_limit || !price) {
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
        return res.status(200).json({ success: true, message: 'Plan added successfully', data: response.toJSON() });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}

export async function updatePlan(req, res) {
    try {
        //values can be null or  undefinded but need to be ignore while updating
        var { plan_name, video_limit, minute_limit, price } = req.body;

        var response = await subscriptionPlan.update({ plan_name, video_limit, minute_limit, price },
            { where: { id: req.params.id } });
        return res.status(200).json({ success: true, message: 'Plan updated successfully', data: response.toJSON() });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }

}

export async function deletePlan(params) {
    try {
        // var response = await subscriptionPlan.destroy({ where: { id: params.id } });
        // return res.status(200).json({ success: true, message: 'Plan deleted successfully', data: response.toJSON() });
        return res.status(200).json({ success: true, message: 'Plan deleted successfully' });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}

