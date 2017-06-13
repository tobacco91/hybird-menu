//
//  MenuWebViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/10.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MenuWebViewController.h"
#import <WebViewJavascriptBridge.h>
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


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = request.URL;
    NSLog(@"%@",url);
    NSString *scheme = url.scheme;
    if ([scheme isEqualToString:@"comment"]) {
        NSLog(@"comment");
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
