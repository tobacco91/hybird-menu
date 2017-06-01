'use strict';
/**
 * relation model
 */
export default class extends think.model.relation {
  /**
   * init
   * @param  {} args []
   * @return {}         []
   */
    init(...args){
        super.init(...args);

        this.relation = {
            step: {
                type: think.model.HAS_MANY,
                model: 'step',
                key: 'menu_id',
                fkey: 'menu_id',
                field: 'menu_id,step_detail,step_order,step_img',
            }
        }
    }

    async getPage(_id) {
        return await this
        .where(_id)
        .field('menu_id,menu_title,menu_introduce,menu_albums,menu_major,menu_burden,write_time,menu_like,menu_collect,write_id')
        .select();
    }
    async getList(_id) {
            return await this.model('menu')
            .where(_id).field('menu_id,menu_title,menu_introduce,menu_albums,menu_like,menu_collect')
            .setRelation(false)
            .select();
    }

    async updateLike(_args) {
        return await this.model('menu')
        .where({
            menu_id: _args.menu_id
        })
        .setRelation(false)
        .increment(_args.type, 1);
    }
}








