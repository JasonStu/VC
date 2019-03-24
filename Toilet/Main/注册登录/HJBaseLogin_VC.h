//
//  HJBaseLogin_VC.h
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJBaseLogin_VC : UIViewController

/** 背景视图图 */
@property (nonatomic, strong ,readonly) UIImageView *bgImageView;
/** 内容视图 */
@property (nonatomic, strong ,readonly) UIView *containerView;
/** logo */
@property (nonatomic, strong) UIButton *logoBtn;
/** 账号输入 */
@property (nonatomic, strong) UITextField *accountTF;
/** 密码输入 */
@property (nonatomic, strong) UITextField *passwordTF;
/** 验证码输入 */
@property (nonatomic, strong) UITextField *codeTF;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginBtn;
/** 注册按钮 */
@property (nonatomic, strong) UIButton *registBtn;
/** 验证码按钮 */
@property (nonatomic, strong) UIButton *codeBtn;
/** 密码登录按钮 */
@property (nonatomic, strong) UIButton *passwordLoginBtn;
/** 重置密码按钮 */
@property (nonatomic, strong) UIButton *resetPasswordBtn;

/** 欢迎 */
@property (nonatomic, strong) UILabel *welcomeLB1;
/** 候鸟 */
@property (nonatomic, strong) UILabel *welcomeLB2;



- (void)keyboardWillShow:(NSNotification *)notif;

- (void)keyboardWillHide:(NSNotification *)notif;

@end
