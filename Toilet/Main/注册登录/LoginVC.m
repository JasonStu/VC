//
//  LoginVC.m
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "SimpleWebVC.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *accountLine;

@property (nonatomic, strong) UIView *passwordLine;

@property (nonatomic, strong) UIView *codeLine;

@end

@implementation LoginVC

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self hideKeyboard];
}

#pragma mark - About UI
- (void)setupUI{
    
    /** 设置self.view */
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    /** 设置背景 */
    [self.bgImageView setImage:[UIImage imageNamed:@"bg_login"]];
//    [self.bgImageView setContentMode:UIViewContentModeScaleAspectFill];
//    self.bgImageView.clipsToBounds = YES;
    [self.view addSubview:self.bgImageView];
    
    /** 设置内容视图 */
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.bgImageView addSubview:self.containerView];
    
    /** 设置logo */
//    [self.containerView addSubview:self.logoBtn];
    
    [self.containerView addSubview:self.welcomeLB1];
    [self.containerView addSubview:self.welcomeLB2];
    
    /** 设置账号输入 */
    self.accountTF.placeholder = @"请输入手机号码/用户名";
    self.accountTF.textColor = RGBOF(0x666666);
    self.accountTF.font = XXBoldFont(16);
    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
    self.accountTF.delegate = self;
    [self.accountTF setValue:XXFont(16) forKeyPath:@"_placeholderLabel.font"];
    UIImageView *accountImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
    accountImageV.contentMode = UIViewContentModeCenter;
    accountImageV.image = [UIImage imageNamed:@"login_name"];
    self.accountTF.leftView = accountImageV;
    [self.containerView addSubview:self.accountTF];
    
    UIView *accountLine = [[UIView alloc] init];
    accountLine.backgroundColor = RGBOF(0xcccccc);
    self.accountLine = accountLine;
    [self.accountTF addSubview:accountLine];
    
    /** 设置密码输入 */
    UIImageView *passwordImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
    passwordImageV.contentMode = UIViewContentModeCenter;
    passwordImageV.image = [UIImage imageNamed:@"login_pwd"];
    self.passwordTF.textColor = RGBOF(0x666666);
    self.passwordTF.font = XXFont(16);
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView = passwordImageV;
    self.passwordTF.placeholder = @"请输入密码";
    self.passwordTF.delegate = self;
    self.passwordTF.secureTextEntry = YES;
    [self.containerView addSubview:self.passwordTF];
    
    UIView *passwordLine = [[UIView alloc] init];
    passwordLine.backgroundColor = RGBOF(0xcccccc);
    self.passwordLine = passwordLine;
    [self.passwordTF addSubview:passwordLine];
    
    
    /** 验证码输入 */
    UIImageView *codeTFImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
    codeTFImageV.contentMode = UIViewContentModeCenter;
    codeTFImageV.image = [UIImage imageNamed:@"login_validate"];
    self.codeTF.textColor = RGBOF(0x666666);
    self.codeTF.font = XXFont(16);
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.leftView = codeTFImageV;
    self.codeTF.placeholder = @"请输入验证码";
    self.codeTF.delegate = self;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.containerView addSubview:self.codeTF];
    
    UIView *codeLine = [[UIView alloc] init];
    codeLine.backgroundColor = RGBOF(0xcccccc);
    self.codeLine = codeLine;
    [self.codeTF addSubview:codeLine];
    self.codeTF.hidden = YES;
    
    /** 验证码按钮 */
    self.codeBtn.layer.cornerRadius = XXAutoLayout(15);
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.borderWidth = 1.f;
    self.codeBtn.layer.borderColor = RGBOF(0xFF9C00).CGColor;
    self.codeBtn.backgroundColor = [UIColor whiteColor];
    self.codeBtn.titleLabel.font = XXFont(14);
    [self.codeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:RGBOF(0xFF9C00) forState:UIControlStateNormal];
    [self.containerView addSubview:self.codeBtn];
    self.codeBtn.hidden = YES;
    
    
    /** 设置登录按钮 */
    self.loginBtn.layer.cornerRadius = XXAutoLayout(25);
    self.loginBtn.layer.masksToBounds = YES;
//    self.loginBtn.layer.borderWidth = 1.f;
//    self.loginBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.loginBtn.backgroundColor = RGBOF(0xcccccc);
    self.loginBtn.titleLabel.font = XXFont(18);
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.containerView addSubview:self.loginBtn];
    
    
    /** 密码登录按钮 */
    self.passwordLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.passwordLoginBtn setTitle:@"动态密码登录" forState:UIControlStateNormal];
    self.passwordLoginBtn.titleLabel.font = XXFont(14);
    [self.passwordLoginBtn addTarget:self action:@selector(passwordLoginActidon:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwordLoginBtn setTitleColor:RGBOF(0xff9c00) forState:UIControlStateNormal];
    [self.containerView addSubview:self.passwordLoginBtn];
    
    
    /** 设置注册按钮 */
    self.registBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = XXFont(14);
    [self.registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.registBtn setTitleColor:RGBOF(0xff9c00) forState:UIControlStateNormal];
    [self.containerView addSubview:self.registBtn];
    
    /** 设置重置密码按钮 */
    self.resetPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.resetPasswordBtn.titleLabel.font = XXFont(14);
    [self.resetPasswordBtn addTarget:self action:@selector(resetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.resetPasswordBtn setTitleColor:RGBOF(0xff9c00) forState:UIControlStateNormal];
    [self.resetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.containerView addSubview:self.resetPasswordBtn];
    
    
    /** 布局 */
    [self make_layout];
}


- (void)make_layout{
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(XXAutoLayout(64));
    }];
    
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.welcomeLB1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView).offset(XXAutoLayout(126 - 64));
        make.left.mas_equalTo(self.containerView).offset(XXAutoLayout(38));
        make.right.mas_equalTo(self.containerView);
        make.height.mas_equalTo(XXAutoLayout(40));
    }];
    
    [self.welcomeLB2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.welcomeLB1.mas_bottom);
        make.left.mas_equalTo(self.containerView).offset(XXAutoLayout(38));
        make.right.mas_equalTo(self.containerView);
        make.height.mas_equalTo(XXAutoLayout(40));
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(280));
        make.height.mas_equalTo(XXAutoLayout(35));
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.accountTF.mas_bottom).offset(XXAutoLayout(30));
    }];
    
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1.f);
    }];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(280 - 120));
        make.height.mas_equalTo(XXAutoLayout(35));
        make.left.mas_equalTo(self.passwordTF);
        make.top.mas_equalTo(self.accountTF.mas_bottom).offset(XXAutoLayout(30));
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(XXAutoLayout(30));
        make.left.mas_equalTo(self.codeTF.mas_right).offset(XXAutoLayout(10));
        make.bottom.mas_equalTo(self.codeTF).offset(XXAutoLayout(-3));
        make.width.mas_equalTo(XXAutoLayout(118));
    }];
    
    [self.codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1.f);
    }];
    
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(280));
        make.height.mas_equalTo(XXAutoLayout(35));
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.welcomeLB2.mas_bottom).offset(XXAutoLayout(92));
    }];
    
    [self.accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1.f);
    }];
    
    [self.passwordLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(150));
        make.height.mas_equalTo(XXAutoLayout(30));
        make.right.mas_equalTo(self.containerView).offset(XXAutoLayout(-60));
        make.top.mas_equalTo(self.passwordTF.mas_bottom).with.offset(XXAutoLayout(5));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(248));
        make.height.mas_equalTo(XXAutoLayout(50));
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.passwordTF.mas_bottom).with.offset(XXAutoLayout(66));
    }];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginBtn);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).with.offset(XXAutoLayout(66));
        make.height.mas_equalTo(XXAutoLayout(40));
        make.width.mas_equalTo((XXAutoLayout(248))/2.f);
    }];
    
    
    [self.resetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.loginBtn);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).with.offset(XXAutoLayout(66));
        make.height.mas_equalTo(XXAutoLayout(40));
        make.width.mas_equalTo((XXAutoLayout(248))/2.f);
    }];
    
}

#pragma mark - Request Data

#pragma mark - Pravite Method
- (void)hideKeyboard{
    
    [self.view endEditing:YES];
}

#pragma mark - Public Method

#pragma mark - Event response
- (void)tapAction{
    
    [self hideKeyboard];
}

- (void)loginAction:(UIButton *)sender{
    
    [self hideKeyboard];
    
    if (self.accountTF.text.length!=11) {
        [MBProgressHUD showMessage:@"请填写有效手机号码"];
        return;
    }
    // 密码登录
    if (self.codeBtn.hidden) {
        NSDictionary *paramDict = @{
                                    @"userNameOrPhone":self.accountTF.text,
                                    @"password":self.passwordTF.text
                                    };
        
        [[ZJNetworkManager shareNetworkManager] POSTWithURL:URL_queryUserByName Parameter:paramDict success:^(NSDictionary *resultDic) {
            
            if (SuccessCode) {
                [[NSUserDefaults standardUserDefaults] setObject:[[resultDic objectForKey:@"data"] objectForKey:@"userCode"] forKey:@"userInfo"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                SimpleWebVC *webVC = [[SimpleWebVC alloc] init];
                webVC.htmlStr = [NSString stringWithFormat:@"http://ce.degjsm.com/phone/home/index.jhtml?usreCode=%@",[[resultDic objectForKey:@"data"] objectForKey:@"userCode"]];
//                [self.navigationController pushViewController:webVC animated:YES];
                [self.navigationController presentViewController:webVC animated:YES completion:^{
                    
                }];
                
//                [MBProgressHUD showMessage:ShowToast];
            }
            else{
                [MBProgressHUD showError:ShowToast];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *description) {
            [MBProgressHUD showError:description];
        }];
    }
    // 验证码登录
    else{
        NSDictionary *paramDict = @{
                                    @"telephone":self.accountTF.text,
                                    @"code":self.codeTF.text
                                    };
        
        [[ZJNetworkManager shareNetworkManager] POSTWithURL:URL_queryUserByPhone Parameter:paramDict success:^(NSDictionary *resultDic) {
            
            if (SuccessCode) {
                
//                [MBProgressHUD showMessage:ShowToast];
            }
            else{
                [MBProgressHUD showError:ShowToast];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *description) {
            [MBProgressHUD showError:description];
        }];
    }
    
    
}

- (void)getCodeAction:(UIButton *)sender{
    
    [self hideKeyboard];
    
    if (self.accountTF.text.length!=11) {
        [MBProgressHUD showMessage:@"请填写有效手机号码"];
        return;
    }
    NSDictionary *paramDict = @{
                                @"telephone":self.accountTF.text
                                };
    
    [[ZJNetworkManager shareNetworkManager] POSTWithURL:URL_sendVerificationCode Parameter:paramDict success:^(NSDictionary *resultDic) {

        if (SuccessCode) {
    
            [self startTime];
            [MBProgressHUD showMessage:ShowToast];
        }
        else{
            [MBProgressHUD showError:ShowToast];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *description) {
        [MBProgressHUD showError:description];
    }];
  
}


- (void)registAction:(UIButton *)sender{
    
    [self hideKeyboard];
    
    RegisterVC *vc = [[RegisterVC alloc] init];
    vc.type = 1;
    XXWeakSelf
    vc.successBlock = ^(NSString *account, NSString *password) {
        weakSelf.accountTF.text = account;
        weakSelf.passwordTF.text = password;
        weakSelf.codeBtn.hidden = YES;
        weakSelf.codeTF.hidden = YES;
        weakSelf.passwordTF.hidden = NO;
        weakSelf.accountTF.placeholder = @"请输入手机号码/用户名";
        weakSelf.accountTF.keyboardType = UIKeyboardTypeDefault;
        [weakSelf.passwordLoginBtn setTitle:@"动态密码登录" forState:UIControlStateNormal];
        [weakSelf canConfirm];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)resetPasswordAction:(UIButton *)sender{
    
    [self hideKeyboard];
    RegisterVC *vc = [[RegisterVC alloc] init];
    vc.type = 2;
    XXWeakSelf
    vc.successBlock = ^(NSString *account, NSString *password) {
        weakSelf.accountTF.text = account;
        weakSelf.passwordTF.text = password;
        weakSelf.codeBtn.hidden = YES;
        weakSelf.codeTF.hidden = YES;
        weakSelf.passwordTF.hidden = NO;
        weakSelf.accountTF.placeholder = @"请输入手机号码/用户名";
        weakSelf.accountTF.keyboardType = UIKeyboardTypeDefault;
        [weakSelf.passwordLoginBtn setTitle:@"动态密码登录" forState:UIControlStateNormal];
        [weakSelf canConfirm];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)passwordLoginActidon:(UIButton *)sender{
    
    
//    SimpleWebVC *webVC = [[SimpleWebVC alloc] init];
//    webVC.htmlStr = @"http://ce.degjsm.com/phone/home/index.jhtml?usreCode=398560";
//    [self.navigationController presentViewController:webVC animated:YES completion:^{
//        
//    }];
    
    [self hideKeyboard];
    if (self.codeBtn.hidden) {
        self.codeBtn.hidden = NO;
        self.codeTF.hidden = NO;
        self.passwordTF.hidden = YES;
        self.accountTF.placeholder = @"请输入手机号码";
        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
        [self.passwordLoginBtn setTitle:@"使用密码登录" forState:UIControlStateNormal];
    }
    else{
        self.codeBtn.hidden = YES;
        self.codeTF.hidden = YES;
        self.passwordTF.hidden = NO;
        self.accountTF.placeholder = @"请输入手机号码/用户名";
        self.accountTF.keyboardType = UIKeyboardTypeDefault;
        [self.passwordLoginBtn setTitle:@"动态密码登录" forState:UIControlStateNormal];
    }
    [self canConfirm];
}

#pragma mark - Delegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self hideKeyboard];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self canConfirm];
    [self hideKeyboard];
}

#pragma mark - Other
- (void)canConfirm{
    if (self.accountTF.text.length && self.codeTF.text.length && !self.codeTF.hidden) {
        self.loginBtn.backgroundColor = RGBOF(0xFF9C00);
        self.loginBtn.userInteractionEnabled = YES;
    }
    else if (self.accountTF.text.length && self.passwordTF.text.length && self.codeTF.hidden) {
        self.loginBtn.backgroundColor = RGBOF(0xFF9C00);
        self.loginBtn.userInteractionEnabled = YES;
    }
    else{
        self.loginBtn.backgroundColor = RGBOF(0xcccccc);
        self.loginBtn.userInteractionEnabled = NO;
    }
    
}

-(void)startTime{
    __block NSInteger timeout= 120; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.codeBtn setTitleColor:RGBOF(0xFF9C00) forState:UIControlStateNormal];
                self.codeBtn.layer.borderColor = RGBOF(0xFF9C00).CGColor;
                self.codeBtn.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%zd秒",timeout--] forState:UIControlStateNormal];
                [self.codeBtn setTitleColor:RGBOF(0xcccccc) forState:UIControlStateNormal];
                self.codeBtn.layer.borderColor = RGBOF(0xcccccc).CGColor;
                [UIView commitAnimations];
                self.codeBtn.userInteractionEnabled = NO;
            });
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - Getters/Setters/Lazy



@end
