'use strict';
/**
 * model
 */
export default class extends think.model.relation {
     init(...args){
        super.init(...args);

        this.relation = {
            reply: {
                type: think.model.HAS_MANY,
                model: 'reply',
                key: 'comment_id',
                fkey: 'comment_id'
            }
        }
    }

    async addComment(_comment) {
        return await this.model('comment')
        .setRelation(false)
        .add(_comment);
    }

    async getComment(_menu) {
        //let sql = `select * from reply,comment where comment_id in (select comment_id from comment where menu_id = ${_menu.menu_id}) OR menu_id = ${_menu.menu_id}`;
        //return await this.query(sql);
        return await this.model('comment')
        .where(_menu)
        .select();
    }
}