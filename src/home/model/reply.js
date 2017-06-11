'use strict';
/**
 * model
 */
export default class extends think.model.base {
    async addReply(_reply) {
        return await this.model('reply')
        .add(_reply);
    }
}