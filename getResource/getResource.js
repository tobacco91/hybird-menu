var request = require('request');
var fs = require('fs');
var connection = require('./connect');
var getToken = require('./getImg');
var url = 'http://apis.juhe.cn/cook/query.php?menu=%E7%82%92%E8%8F%9C&dtype=&pn=&rn=&albums=&=&key=f9e6c1e14615db3a812f8c40dd73a555';
var body = '';
for (let i = 0 ;i < 30 ; i = i+5) {
    setInterval(()=>{
            let j  = i;
            request(url,function(err,res,body) {
                console.log(JSON.parse(body).result.data.length)
                var data = JSON.parse(body).result.data.slice(j,j+5);
                
                data.map(function(item, index) {

                    var albumsPath = '../resource/albums/5';
                    connection.query('INSERT INTO menu SET ?',{
                        menu_title: item.title,
                        menu_introduce: item.imtro,
                        menu_major: item.ingredients,
                        menu_burden: item.burden,
                        menu_like: 0,
                        menu_collect: 0,
                        write_id: 0,
                        sort_id: 5,
                        menu_state: 1
                    },function(err, result, fields) {
                        //console.log(item.albums[0]);
                        getToken(result.insertId, {path: albumsPath, imgUrl: item.albums[0]})
                        .then(res => {
                            connection.query('UPDATE menu SET menu_albums = ? WHERE menu_id = ?',[res, result.insertId]);
                        });
                        let stepPath = result.insertId;
                        fs.mkdir('../resource/step/' + stepPath, 0777, (err) => {});
                        item.steps.map((step, i) => {
                            //console.log(step.img);
                            getToken(i + 1, {path: '../resource/step/' + stepPath + '/', imgUrl: step.img})
                            .then(res => {
                                //console.log(res);
                                connection.query('INSERT INTO step SET ?',{
                                    step_detail: step.step,
                                    step_order: i + 1,
                                    step_img: stepPath+'/'+ res,
                                    menu_id: stepPath 
                                },(err,result, feilds) => console.log(err))
                            })
                        })
                    })
                    
                })
            })




    },20000);
}
// request(url,function(err,res,body) {
//     var data = JSON.parse(body).result.data.slice(10,11);
//     data.map(function(item, index) {

//         var albumsPath = '../resource/albums/4';
//         connection.query('INSERT INTO menu SET ?',{
//             menu_title: item.title,
//             menu_introduce: item.imtro,
//             menu_major: item.ingredients,
//             menu_burden: item.burden,
//             menu_like: 0,
//             menu_collect: 0,
//             write_id: 0,
//             sort_id: 4,
//             menu_state: 1
//         },function(err, result, fields) {
//             console.log(item.albums[0]);
//             getToken(result.insertId, {path: albumsPath, imgUrl: item.albums[0]})
//             .then(res => {
//                 connection.query('UPDATE menu SET menu_albums = ? WHERE menu_id = ?',[res, result.insertId]);
//             });
//             let stepPath = result.insertId;
//             fs.mkdir('../resource/step/' + stepPath, 0777, (err) => {});
//             item.steps.map((step, i) => {
//                 //console.log(step.img);
//                 getToken(i + 1, {path: '../resource/step/' + stepPath + '/', imgUrl: step.img})
//                 .then(res => {
//                     //console.log(res);
//                     connection.query('INSERT INTO step SET ?',{
//                         step_detail: step.step,
//                         step_order: i + 1,
//                         step_img: stepPath+'/'+ res,
//                         menu_id: stepPath 
//                     },(err,result, feilds) => console.log(err))
//                 })
//             })
//         })
        
//     })
// })
