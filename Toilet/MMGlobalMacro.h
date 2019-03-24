//
//  MMGlobalMacro.h
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#ifndef MMGlobalMacro_h
#define MMGlobalMacro_h

#define DomainURL @"http://ce.degjsm.com"

// 1、启动页
#define URL_queryBanners @"/phone/home/queryBanners.jhtml"
// 9、根据用户名/手机号，密码登陆
#define URL_queryUserByName @"/phone/user/queryUserByName.jhtml"
// 10、根据手机号，验证码登陆
#define URL_queryUserByPhone @"/phone/user/queryUserByPhone.jhtml"
// 11、发送验证码
#define URL_sendVerificationCode @"/phone/user/sendVerificationCode.jhtml"
// 12、查询用户名是否被使用
#define URL_queryUserName @"/phone/user/queryUserName.jhtml"
// 13、注册
#define URL_registeredUser @"/phone/user/registeredUser.jhtml"
// 39、修改登陆密码
#define URL_updateLoginPassword @"/phone/user/updateLoginPassword.jhtml"

//请求成功状态码
#define SuccessCode [resultDic[@"status"] intValue] == 1
#define ShowToast  resultDic[@"message"]


#ifdef DEBUG // 开发调试阶段

/** 打印 */
#define XXLog(...) NSLog(__VA_ARGS__);

#else // 打包测试阶段

#define XXLog(...)

#endif

/*------------Debug 打印-----------*/
#ifdef DEBUG

#define ZJLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

#define ZJLog( s, ... )

#endif

/** 定义self的弱指针 */
#define XXWeakSelf __weak typeof(self) weakSelf = self;
#define XXSelf __strong typeof(weakSelf) self = weakSelf;

/*********************** 系统判断 ********************/
#define IOS8            ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8)

#define IOS9            ([[[UIDevice currentDevice] systemVersion] integerValue] >= 9)

#define IOS10            ([[[UIDevice currentDevice] systemVersion] integerValue] >= 10)

#define IOS11            ([[[UIDevice currentDevice] systemVersion] integerValue] >= 11)

// 屏幕尺寸
#define XX_SCREEN_WIDTH   (([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define XX_SCREEN_HEIGHT  (([[UIScreen mainScreen] bounds].size.height > [[UIScreen mainScreen] bounds].size.width) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define XX_SCREEN_BOUNDS  [UIScreen mainScreen].bounds

// 机型
#define SCREEN_MAX_LENGTH (MAX(XX_SCREEN_WIDTH, XX_SCREEN_HEIGHT))


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_4  (IS_IPHONE && SCREEN_MAX_LENGTH == 480.0)
#define IS_IPHONE_5  (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6  (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X  (IS_IPHONE && SCREEN_MAX_LENGTH  == 812.0)
// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone Xr
#define iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone XS Max
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


/*********************** UI控制 ********************/
#define lineHeight22  (22.f * XXScreenWidthScale);
#define lineHeight25  (25.f * XXScreenWidthScale);
// 屏幕宽度的比例
#define XXScreenWidthScale ((XX_SCREEN_WIDTH) / 375.0)
// 屏幕高度的比例
#define XXScreenHeightScale ((XX_SCREEN_HEIGHT) / 667.0)
// UI适配
#define XXAutoLayout(value) ((value) * XXScreenWidthScale)

// 字体
#define XXFont14 [UIFont systemFontOfSize:(14 * XXScreenWidthScale)]
#define XXFont16 [UIFont systemFontOfSize:(16 * XXScreenWidthScale)]
#define XXFont18 [UIFont systemFontOfSize:(18 * XXScreenWidthScale)]
#define XXFont20 [UIFont systemFontOfSize:(20 * XXScreenWidthScale)]
#define XXFont(font) [UIFont systemFontOfSize:((font) * XXScreenWidthScale)]
#define XXBoldFont(font) [UIFont boldSystemFontOfSize:((font) * XXScreenWidthScale)]

#define RGBOF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                             blue:((float)(rgbValue & 0xFF))/255.0 \
                                            alpha:1.0]

#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:(a)]

// 导航栏
#define XXNavBarMaxYValue ((IS_IPHONE_X) ? 88 : 64)
// 导航栏高度
#define XXNavBarHValue (44)
// tabbar高度
#define XXTabBarHValue ((IS_IPHONE_X) ? 83 : 49)
// 状态栏高度
#define XXStatusBarHValue ((IS_IPHONE_X) ? 44 : 20)
// iPhoneX底部高度
#define XXiPhoneXBottomHValue ((IS_IPHONE_X) ? 34 : 0)

/*********************** 颜色控制 ********************/
/** 自定义颜色*/
#define XXRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define XXRGBColor(r,g,b) XXRGBAColor(r,g,b,1)
#define XXRandomColor XXRGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))


#define XXGlobeThemeColor XXRGBColor(229,67,54) // 主题颜色, 待定
#define XXGlobeBGColor XXRGBColor(250,250,250)    // 底板颜色, 待定
#define XXSeparateLineColor XXRGBColor(219,219,219) // 分割线颜色, 待定

/*********************** 占位图片 ********************/
// 头像占位图片
#define XXPlaceholderPortraitImage [UIImage imageNamed:@"portrait_placeholder"]
// 封面占位
#define XXPlaceholderCoverImage [UIImage imageNamed:@"封面占位"]


#endif /* MMGlobalMacro_h */
