// function getToken (args) {
//     return new Promise((resolve, reject) => {
//         resolve(args)
//     })   
// }

// getToken('dadad').then(res => console.log(res))
// var fs = require('fs');
// fs.mkdir('../resource/step/1',0777, (err) => console.log(err))
var getToken = require('./getImg');
getToken( 2, {path: '../resource/step/', imgUrl: "http://juheimg.oss-cn-hangzhou.aliyuncs.com/cookbook/s/129/12862_acad5dcd86d7ac19.jpg"})
                .then(res => {
                    console.log(res);
                })
                getToken( 3, {path: '../resource/step/', imgUrl: 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/cookbook/s/129/12862_10e4269f57f58607.jpg'})
                .then(res => {
                    console.log(res);
                })