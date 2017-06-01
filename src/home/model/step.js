'use strict';
/**
 * model
 */
export default class extends think.model.base {
    async getPage(_id) {
        return await this.model('step')
        .where(_id).field('step_detail,step_order,step_img')
        .order('step_order')
        .select();
    }
}