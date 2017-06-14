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
        return await this.model('comment')
        .where(_menu)
        .select();
    }
}