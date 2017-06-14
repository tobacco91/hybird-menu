//
//  MenuWebViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/10.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MenuWebViewController.h"
#import <WebViewJavascriptBridge.h>
#import "CommentViewController.h"
@interface MenuWebViewController ()<UIWebViewDelegate>
@property UIWebView *webView;
@property NSURLRequest *request;
@property WebViewJavascriptBridge *bridge;
@end

@implementation MenuWebViewController
- (instancetype)initWithRequest:(NSURLRequest *)request{
    self = [self init];
    if(self){
        self.request = request;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.webView loadRequest:self.request];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
//    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];

//    [self.bridge registerHandler:@"comment" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"ObjC Echo called with: %@", data);
//        responseCallback(data);
//    }];
//    [self.bridge callHandler:@"JS Echo" data:nil responseCallback:^(id responseData) {
//        NSLog(@"ObjC received response: %@", responseData);
//    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [self.webView reload];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = request.URL;
    NSString *scheme = url.scheme;
    NSString *host = url.host;
    NSDictionary *parameter = [AppUtility getURLParameters:url.absoluteString];
    if ([scheme isEqualToString:@"menu"]) {
        CommentType type = Comment;
        NSString *ID = @"";
        NSString *vcTitle = @"写评论";
        if ([host isEqualToString:@"comment"]) {
            ID = [parameter objectForKey:@"menu_id"];
        }
        else if([host isEqualToString:@"reply"]){
            type = Reply;
            ID = [parameter objectForKey:@"comment_id"];
            NSString *comment_name = [parameter objectForKey:@"comment_name"];
            vcTitle = [NSString stringWithFormat:@"回复:%@",comment_name];
            
        }
        CommentViewController *commentVC = [[CommentViewController alloc]initWithCommentType:type andID:ID];
        commentVC.title = vcTitle;
        [self.navigationController pushViewController:commentVC animated:YES];
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
