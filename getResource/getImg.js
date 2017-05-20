var crypto = require('crypto');
var http = require('http');
var fs = require('fs');


function getImg(imgUrl,path,fileName) {
    http.get(imgUrl,function(res) {
        var imgData = '';
        res.setEncoding('binary');
        res.on('data',function(data) {
            imgData += data;
        })
        res.on('end',function() {
            fs.writeFile(path+ '/' + fileName + '.jpg', imgData,'binary' ,function(err) {
                if(err) {
                    console.log(err)
                } else {
                    //console.log('getImg' + fileName + 'success');
                }
            }) 
        })
    })
}



function getToken (before = '',args) {
    return new Promise((resolve, reject) => {
        crypto.randomBytes(8, function(ex, buf) {  
            var token = before +'_' + buf.toString('hex');
            getImg(args.imgUrl, args.path, token);
            resolve(token + '.jpg');
        });
    })
    
}


module.exports = getToken;
