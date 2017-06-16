'use strict';
/**
 * model
 */
export default class extends think.model.base {
    async addCollect(_id) {
        return await this.model('collect')
        //.setRelation(false)
        .thenAdd(_id,{menu_id: _id.menu_id,user_id: _id.user_id})
    }
    async getCount(_id) {
        return await this.model('collect')
        .where(_id)
        //.setRelation(false)
        .count();
    }
    async getMenu(_id) {
        return await this.model('collect')
        .where(_id)
        .select();
    }

    async personCollect(_id) {
        let sql = `select menu_id, menu_title, menu_introduce, menu_albums, menu_like, menu_collect from menu where menu_id in (select menu_id from collect where user_id = ${_id.user_id})`;
        return await this
        .query(sql);
    }
}