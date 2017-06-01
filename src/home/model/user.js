'use strict';
/**
 * model
 */
export default class extends think.model.base {
    async checkUser(_user) {
        return await this.model('user')
        .where(_user)
        .find();
    }
    /**
     * return {
     *  id
     *  type: add/exits
     * }
     */
    async addUser(_user) {
        return await this.model('user')
        .thenAdd(_user,{user_name:_user.user_name});
    }

    async getName(_id) {
        return await this.model('user')
        .where(_id)
        .field('user_name')
        .find();
    }
}