//
//  BaseViewController.h
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic,copy) void(^backRefreshBlock)();

@property(nonatomic,copy) void(^backStringBlock)(NSString *);


-(void)loginSuccessActionWithDict:(NSDictionary *)dict;


-(void)cleanNavBar;
/*1.隐藏导航栏，基类默认显示导航栏*/
-(void)hideNavBar;
-(void)showNavBar;

/*2.LoadingView和空数据视图显示隐藏*/
//显示Loading
-(void)showLoading;
//隐藏Loading
-(void)hideLoading;

-(void)backMethod;

/*3.toast提示(只文字)*/
-(void)showToast:(NSString *)toast;

/*4.简单的网页跳转*/
-(void)skipToSimpleWebWithUrl:(NSString *)url andTitle:(NSString *)title;
-(void)skipToSimpleWebWithHtmlStr:(NSString *)htmlStr andTitle:(NSString *)title;
/*5.回到首页*/
-(void)backToHome;
/*6.跳转登陆*/
-(void)goToLogin;

/*7.拨打电话*/
-(void)callWithNumber:(NSString *)number;
/*8.判断登录状态*/
-(BOOL)judgeLoginStatus;

/*9.导航栏按钮设置*/
//左侧按钮
- (void)setLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector;
- (void)setLeftItemWithIcon:(UIImage *)icon selector:(SEL)selector;
- (void)setLeftItemWithTitle:(NSString *)title selector:(SEL)selector;
//右侧按钮
- (void)setRightItemWithTitle:(NSString *)title selector:(SEL)selector;
- (void)setRightItemWithIcon:(UIImage *)icon selector:(SEL)selector;


@end

