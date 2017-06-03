
url | args | method
---|---|---|---
http://www.cxy91.cn/user/register | name&password |post
http://www.cxy91.cn/user/login | name&password | post
http://www.cxy91.cn/user/list （列表）| sort_id//分类id（1到5） | get
http://www.cxy91.cn/user/page（详情页） | menu_id | get
http://www.cxy91.cn/user/show_collect（收藏页显示） |user_id | get
http://www.cxy91.cn/user/add_one（点赞或收藏） | user_id&menu_id&type(type=menu_like / menu_collect 点赞还是收藏) | get
http://www.cxy91.cn:8360/user/person（个人页） | user_id | get
http://www.cxy91.cn/static/img/albums/720_c1526f0b1f35d5b4.jpg(各个封面) ||get
http://www.cxy91.cn/static/img/step/720/1_506bf42b22bb0c5b.jpg(各种步骤) | | get