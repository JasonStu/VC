//
//  SimpleWebVC.m
//  Toilet
//
//  Created by 覃木春 on 2019/3/19.
//  Copyright © 2019 MM. All rights reserved.
//

#import "SimpleWebVC.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <AlipaySDK/AlipaySDK.h>

@interface SimpleWebVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (strong, nonatomic)WKWebView *wkWebView;
@property (strong, nonatomic)UIView *navigationBarV;


@end

@implementation SimpleWebVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.navigationBarV];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://focant.viphk1.ngrok.org/#/"]]];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    _wkWebView.alpha = 1;
    _navigationBarV.alpha = 1;
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
//    [self.wkWebView evaluateJavaScript:@"payStatus(1)" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
//        NSLog(@"alert");
//    }];
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userController = [[WKUserContentController alloc] init];
        configuration.userContentController = userController;
        _wkWebView = [[WKWebView alloc]initWithFrame: CGRectMake(0, (iPhoneX || iPhoneXr || iPhoneXSMax) ?  -24 : -20, XX_SCREEN_WIDTH, XX_SCREEN_HEIGHT + ((iPhoneX || iPhoneXr || iPhoneXSMax) ? 24 : 20)) configuration:configuration];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        _wkWebView.alpha = 0;
        [userController addScriptMessageHandler:self name:@"pay"];

    }
    return _wkWebView;
}

-(UIView *)navigationBarV{
    if (!_navigationBarV) {
        _navigationBarV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XX_SCREEN_WIDTH, (iPhoneX || iPhoneXr || iPhoneXSMax) ?  44 : 0)];
        _navigationBarV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationBar"]];
        _navigationBarV.alpha = 0;
    }
    return _navigationBarV;
}

@end
