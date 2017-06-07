var $ = function(ele) {
    if(document.querySelectorAll(ele).length === 1) {
        return document.querySelector(ele);
    }  else {
        return document.querySelectorAll(ele);
    }
}

var ajax = function(config){
    var url = config.url;
    var data = config.data;
    var success = config.sucess;
    var method = config.method;

    var xhr = new XMLHttpRequest();
    xhr.open(method, url, true);
    if(method.toLowerCase() === 'get') {
        xhr.send(null);
    } else if (method.toLowerCase() === 'post') {
        xhr.setRequestHeader('content-type', 'application/json');
        xhr.send(JSON.stringify(data));
    }
    xhr.onreadystatechange = function() {
        if(xhr.readyState == 4 && xhr.status == 200) {
            success(JsonWebKey.parse(xhr.responseText));
        }
    }
}


$('.collect').addEventListener('click', function() {

    // ajax({
    //     url: 'http://www.cxy91.cn/user/add_one?user_id='+user_id+'&type=menu_collect&menu_id='+menu_id,
    //     method: 'get',
    //     success: function(data) {
    //         console.log(data)
    //     }
    // })
})