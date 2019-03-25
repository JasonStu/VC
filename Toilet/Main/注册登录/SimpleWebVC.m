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
//#import "WXApiObject.h"
#import <WXApiObject.h>
//#import "WXApi.h"
#import <WXApi.h>

@interface SimpleWebVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (strong, nonatomic)WKWebView *wkWebView;
@property (strong, nonatomic)UIView *navigationBarV;


@end

@implementation SimpleWebVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.navigationBarV];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFirst:) name:@"wechatPay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFirst:) name:@"aliPay" object:nil];

     NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://focant.viphk1.ngrok.org/#/home?userCode=%@",str]]]];
//    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.htmlStr]]];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)notificationFirst:(NSNotification *)resp{
    if ([resp.userInfo[@"errorCode"]isEqualToString:@"0"] ) {
        [self.wkWebView evaluateJavaScript:@"window.lrsfvm.$root.eventHub.$emit('payStatus', {payStatus:1})" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
        }];
    }else{
        [self.wkWebView evaluateJavaScript:@"window.lrsfvm.$root.eventHub.$emit('payStatus', {payStatus:0})" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
            
        }];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    _wkWebView.alpha = 1;
    _navigationBarV.alpha = 1;
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
//    [self.wkWebView evaluateJavaScript:@"payStatus(1)" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
//        NSLog(@"alert");
//    }];
    
    if ([message.name isEqualToString:@"pay"]) {
        NSDictionary *body = [NSDictionary dictionaryWithDictionary:message.body];
        
        if ([body[@"type"] isEqualToString:@"alipay"]) {
            [self alipayAction:body[@"body"]];
        }else if ([body[@"type"] isEqualToString:@"wechat"]){
            [self wechatPayAction:body[@"body"]];
        }
    }else if ([message.name isEqualToString:@"pushImg"]){
        
    }
    
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)alipayAction:(NSString *)key{
    [[AlipaySDK defaultService] payOrder:(NSString *)key fromScheme:@"EVCe" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
  
    }];
}

-(void)wechatPayAction:(NSDictionary *)data{
    PayReq* req             = [PayReq new];
    req.partnerId           = data[@"partnerId"];
    req.prepayId            = data[@"prepayId"];
    req.nonceStr            = data[@"nonceStr"];
    req.timeStamp           = [data[@"timeStamp"] unsignedIntValue];
    req.package             = data[@"packageValue"];
    req.sign                = data[@"paySign"];
    BOOL success = [WXApi sendReq:req];
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
        [userController addScriptMessageHandler:self name:@"pushImg"];
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
