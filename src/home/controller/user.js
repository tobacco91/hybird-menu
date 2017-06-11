'use strict';

import Base from './base.js';

export default class extends Base {
  /**
   * index action
   * @return {Promise} []
   */
  async listAction(){
    let sortId = this.get('sort_id');
    let pageNum = this.get('page_num');
    let list = await this.model('menu')
    .getList({
        sort_id: sortId,
        menu_state: 1
    },pageNum);
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
        let comment = await this.getComment(menuId);
        let userId = this.get('user_id') === '' ? 'undefined' : this.get('user_id');
        this.assign('comment',comment);
        this.assign('data',page);
        this.assign({user_id : userId});
        this.display();
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
            //await this.session('userId',info.user_id);
            return this.json(
                {
                    status: 200,
                    message: {user_id:info.user_id}
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
          user_password:    think.md5(user.password)
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
    let userId = this.get('user_id');
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
            if(userId === '') {
                return this.json(
                    {
                        status: 400,
                        message: '请先登录'
                    }
                )
            }
            let state = await this.model('collect')
            .addCollect({
                menu_id: addMessage.menu_id,
                user_id: userId
            });
            if(state.type === 'add') {
                return this.json(
                    {
                        status: 200,
                        message: '收藏成功'
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
      let id = this.get('user_id');
      if(id === '') {
        return this.json(
            {
                status: 400,
                message: '请先登录'
            }
        )
      }
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
    let id = this.get('user_id');
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

  
  async addCommentAction() {
      let user_id = this.get('user_id');
      let menu_id = this.get('menu_id');
      let content = this.get('content');
      let time =  new Date();
      let userName = await this.model('user')
      .getName({
          user_id: user_id
      });
      let info = await this.model('comment')
      .addComment({
          write_id: user_id,
          write_name: userName.user_name,
          menu_id: menu_id,
          comment_detail: content
      });
      return this.json(
            {
                status: 200,
                message: '评论成功(•̀ᴗ•́)و '
            })
  }


  async addReplyAction() {
     let user_id = this.get('user_id');
     let comment_id = this.get('comment_id');
     let content = this.get('content');
     let userName = await this.model('user')
      .getName({
          user_id: user_id
      });
     await this.model('reply')
     .addReply({
          write_id: user_id,
          write_name: userName.user_name,
          reply_detail: content,
          comment_id : comment_id
     }) 
    return this.json({
        status: 200,
        message: '回复成功(•̀ᴗ•́)و '
    })
  }

  async getComment(menu_id) {
      let data = await this.model('comment')
      .getComment({
          menu_id: menu_id
      });
      return data;
  }
}