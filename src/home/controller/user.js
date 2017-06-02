'use strict';

import Base from './base.js';

export default class extends Base {
  /**
   * index action
   * @return {Promise} []
   */
  async listAction(){
    let sortId = this.get('sort_id');
    let list = await this.model('menu')
    .getList({
        sort_id: sortId,
        menu_state: 1
    });
    if (think.isEmpty(list)) {
        return this.json(
            {
                status: 204,
                message: '还没有菜单，快来填写你的菜单吧'
            }
        )
    } else {
        return this.json(
            {
                status: 200,
                message: list
            }
        )
    }
  }



    async pageAction(){
        let menuId = this.get('menu_id');
        let page = await this.model('menu')
        .getPage({
            menu_id: menuId
        });
        if (think.isEmpty(page)) {
            return this.json(
                {
                    status: 400,
                    message: '没有获取数据'
                }
            )
        } else {
            return this.json(
                {
                    status: 200,
                    message: page
                }
            )
        }
    }

    async loginAction() {
        let user = this.post();
        let info = await this.model('user')
        .checkUser({
            user_name    :    user.name,
            user_password:    think.md5(user.password)
        });
        if (think.isEmpty(info)) {
            return this.json(
                {
                    status: 400,
                    message: '账号密码错误'
                }
            )
        } else {
            await this.session('userId',info.user_id);
            return this.json(
                {
                    status: 200,
                    message: '成功登陆'
                }
            )
        }
    }
    async registerAction() {
      let user = this.post();
      console.log(user)
      let info = await this.model('user')
      .addUser({
          user_name    :    user.name,
          user_password:    think.md5(user.user_password)
      });
      if (info.type === 'exist') {
        return this.json(
            {
                status: 400,
                message: '用户名已存在'
            }
        )
    } else if(info.type === 'add') {
        return this.json(
            {
                status: 200,
                message: '注册成功'
            }
        )
    }
  }
  /**点赞or收藏
   * get{
   * menu_id
   * type:menu_like/menu_collect
   * }
   */
  async addOneAction() {
    let userId = await this.session('user');
    console.log(userId)
    console.log(userId == 'undefined')
    if(userId === 'undefined') {
        return this.json(
            {
                status: 400,
                message: '请先登录'
            }
        )
    }
    let addMessage = this.get();
    let info = await this.model('menu')
    .updateLike({
        menu_id : addMessage.menu_id,
        type    : addMessage.type
    });
    
    if (think.isEmpty(info)) {
        return this.json(
            {
                status: 400,
                message: '操作失败'
            }
        )
    } else {
        if(addMessage.type ==='menu_like') {
            return this.json(
                {
                    status: 200,
                    message: '操作成功'
                }
            )
        } else if(addMessage.type ==='menu_collect') {
            let state = await this.model('collect')
            .addCollect({
                menu_id: addMessage.menu_id,
                user_id: await this.session('userId')
            });
            if(state.type === 'add') {
                return this.json(
                    {
                        status: 200,
                        message: '操作成功'
                    }
                )
            } else if (state.type === 'exist') {
                return this.json(
                    {
                        status: 400,
                        message: '已经收藏，不可再次收藏'
                    }
                )
            }
            
        }
        
    }
  }


  /**
   * 个人页
   * 
   */
  async personAction() {
      //await this.session('userId',1);
      let id = await this.session('userId');
      let userName = await this.model('user')
      .getName({
          user_id: id
      });
      let collectCount = await this.model('collect')
      .getCount({
          user_id: id
      });
      return this.json(
        {
            status: 200,
            message: {
                userName: userName.user_name,
                collectCount: collectCount
            }
        }
      )
  }

  /**
   * 收藏页
   */

  async showCollectAction() {
      //await this.session('userId',1);
    let id = await this.session('userId');
    let list = await this.model('collect')
    .personCollect({
        user_id: id
    });
    if (think.isEmpty(list)) {
        return this.json(
            {
                status: 204,
                message: '还没有收藏，快去收藏吧'
            }
        )
    } else {
        return this.json(
            {
                status: 200,
                message: list
            }
        )
    }
  }

}