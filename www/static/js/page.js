
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
    var success = config.success;
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
            success(JSON.parse(xhr.responseText));
        }
    }
}

var createIframe = function(url) {
    var iframe = document.createElement('iframe');
    iframe.width = '1px';
    iframe.height = '1px';
    iframe.display = 'none';
    iframe.src = url;
    document.body.appendChild(iframe);
    setTimeout(function() {
        iframe.remove();
    },0);
}


ajax({
    url: '/user/add_one',
    method: 'post',
    data: {
        type:'menu_like',
        menu_id: menu_id
    },
    success: function(data) {
        console.log(data)
    }
})

$('.collect').addEventListener('click', function() {
    ajax({
        url: '/user/add_one',
        method: 'post',
        data: {
            user_id: user_id,
            type: 'menu_collect',
            menu_id: menu_id
        },
        success: function(data) {
            $('.state').innerHTML = data.message;
            $('.state').style.display = 'block';
            setTimeout(function(){
                $('.state').style.display = 'none';
            },2000);
        }
    })
})
        
$('.leave').addEventListener('click',function() {
    if(user_id === '') {
        $('.state').innerHTML = '请先登录';
        $('.state').style.display = 'block';
        setTimeout(function(){
            $('.state').style.display = 'none';
        },2000);
    } else {
         createIframe('menu://comment?menu_id='+menu_id+'&user_id='+user_id);
    }
});

$('.comment-list').addEventListener('click',function(e){
    //console.log(this.className)
    //console.log(e.target.getAttribute('comment_id'))
    if(e.target && e.target.id === 'comment') {
        var comment_id = e.target.getAttribute('comment_id');
        var comment_name = e.target.parentNode.children[0].innerHTML;
        createIframe('menu://reply?user_id='+user_id+'&comment_id='+comment_id+'&comment_name='+comment_name);
    }
    
})

