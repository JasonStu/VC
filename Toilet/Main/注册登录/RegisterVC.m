//
//  RegisterVC.m
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()<UITextFieldDelegate>

/** 背景视图图 */
@property (nonatomic, strong) UIImageView *bgImageView;
/** 内容视图 */
@property (nonatomic, strong) UIView *containerView;
/** 账号输入 */
@property (nonatomic, strong) UITextField *accountTF;
@property (nonatomic, strong) UIView *accountLine;
/** 验证码输入 */
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIView *codeLine;
/** 验证码按钮 */
@property (nonatomic, strong) UIButton *codeBtn;
/** 密码输入 */
@property (nonatomic, strong) UITextField *passwordTF1;
@property (nonatomic, strong) UIView *passwordLine1;
/** 二次密码输入 */
@property (nonatomic, strong) UITextField *passwordTF2;
@property (nonatomic, strong) UIView *passwordLine2;
/** 提交按钮 */
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.passwordTF1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.passwordTF2];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - About UI
- (void)setupUI{
    
    /** 设置self.view */
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.type == 1) {
        self.title = @"注册";
    }
    else{
        self.title = @"找回密码";
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    /** 设置背景 */
    [self.bgImageView setImage:[UIImage imageNamed:@"bg_register"]];
//    [self.bgImageView setContentMode:UIViewContentModeScaleAspectFill];
//    self.bgImageView.clipsToBounds = YES;
    [self.view addSubview:self.bgImageView];
    
    /** 设置内容视图 */
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.bgImageView addSubview:self.containerView];
    
    /** 设置账号输入 */
    self.accountTF.placeholder = self.type == 1 ? @"请输入手机号码" : @"请输入手机号码/用户名";
    self.accountTF.keyboardType = self.type == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
    self.accountTF.textColor = RGBOF(0x666666);
    self.accountTF.font = XXBoldFont(16);
    [self.accountTF setValue:XXFont(16) forKeyPath:@"_placeholderLabel.font"];
    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
    self.accountTF.delegate = self;
    UIImageView *accountImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
    accountImageV.contentMode = UIViewContentModeCenter;
    accountImageV.image = [UIImage imageNamed:@"login_name"];
    self.accountTF.leftView = accountImageV;
    [self.containerView addSubview:self.accountTF];
    
    UIView *accountLine = [[UIView alloc] init];
    accountLine.backgroundColor = RGBOF(0xcccccc);
    self.accountLine = accountLine;
    [self.accountTF addSubview:accountLine];
    
    /** 验证码输入 */
    UIImageView *codeTFImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
    codeTFImageV.contentMode = UIViewContentModeCenter;
    codeTFImageV.image = [UIImage imageNamed:@"login_validate"];
    self.codeTF.textColor = RGBOF(0x666666);
    self.codeTF.font = XXFont(16);
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.leftView = codeTFImageV;
    self.codeTF.placeholder = @"请输入验证码";
    self.codeTF.delegate = self;
    [self.containerView addSubview:self.codeTF];
    
    UIView *codeLine = [[UIView alloc] init];
    codeLine.backgroundColor = RGBOF(0xcccccc);
    self.codeLine = codeLine;
    [self.codeTF addSubview:codeLine];
    
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
    
    /** 设置密码输入 */
    UIImageView *passwordImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
    passwordImageV.contentMode = UIViewContentModeCenter;
    passwordImageV.image = [UIImage imageNamed:@"icon_pwd_default"];
    self.passwordTF1.textColor = RGBOF(0x666666);
    self.passwordTF1.font = XXFont(16);
    self.passwordTF1.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF1.leftView = passwordImageV;
    self.passwordTF1.placeholder = @"输入密码6-12位";
    self.passwordTF1.delegate = self;
    self.passwordTF1.secureTextEntry = YES;
    [self.containerView addSubview:self.passwordTF1];
    
    UIView *passwordLine = [[UIView alloc] init];
    passwordLine.backgroundColor = RGBOF(0xcccccc);
    self.passwordLine1 = passwordLine;
    [self.passwordTF1 addSubview:passwordLine];
    
    UIImageView *passwordImageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
    passwordImageV2.contentMode = UIViewContentModeCenter;
    passwordImageV2.image = [UIImage imageNamed:@"icon_pwd_default"];
    self.passwordTF2.textColor = RGBOF(0x666666);
    self.passwordTF2.font = XXFont(16);
    self.passwordTF2.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF2.leftView = passwordImageV2;
    self.passwordTF2.placeholder = @"确认密码";
    self.passwordTF2.delegate = self;
    self.passwordTF2.secureTextEntry = YES;
    [self.containerView addSubview:self.passwordTF2];
    
    UIView *passwordLine2 = [[UIView alloc] init];
    passwordLine2.backgroundColor = RGBOF(0xcccccc);
    self.passwordLine2 = passwordLine2;
    [self.passwordTF2 addSubview:passwordLine2];

    
    /** 设置提交按钮 */
    self.loginBtn.layer.cornerRadius = XXAutoLayout(25);
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = RGBOF(0xcccccc);
    self.loginBtn.titleLabel.font = XXFont(18);
    [self.loginBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.containerView addSubview:self.loginBtn];
    
    /** 布局 */
    [self make_layout];

}

- (void)make_layout{
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(XXAutoLayout(29));
    }];
    
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(280));
        make.height.mas_equalTo(XXAutoLayout(35));
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.containerView).offset(XXAutoLayout(150 + 29));
    }];
    
    [self.accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1.f);
    }];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(280 - 120));
        make.height.mas_equalTo(XXAutoLayout(35));
        make.left.mas_equalTo(self.accountTF);
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
    
    [self.passwordTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(280));
        make.height.mas_equalTo(XXAutoLayout(35));
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.codeTF.mas_bottom).offset(XXAutoLayout(30));
    }];

    [self.passwordLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1.f);
    }];

    [self.passwordTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(280));
        make.height.mas_equalTo(XXAutoLayout(35));
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.passwordTF1.mas_bottom).offset(XXAutoLayout(30));
    }];

    [self.passwordLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1.f);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XXAutoLayout(248));
        make.height.mas_equalTo(XXAutoLayout(50));
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.passwordTF2.mas_bottom).with.offset(XXAutoLayout(66));
    }];
}


#pragma mark - Event response

- (void)hideKeyboard{
    
    [self.view endEditing:YES];
}

- (void)tapAction{
    
    [self hideKeyboard];
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

- (void)confirmAction:(UIButton *)sender{
    
    [self hideKeyboard];
  
    
    if (self.type == 1) {
        if (self.accountTF.text.length!=11) {
            [MBProgressHUD showMessage:@"请填写有效手机号码"];
            return;
        }
        NSDictionary *paramDict = @{
                                    @"telephone":self.accountTF.text,
                                    @"userName":self.accountTF.text,
                                    @"password":self.passwordTF1.text,
                                    @"repassword":self.passwordTF2.text,
                                    @"code":self.codeTF.text,
                                    @"parentUserCode":@""
                                    };
        
        [[ZJNetworkManager shareNetworkManager] POSTWithURL:URL_registeredUser Parameter:paramDict success:^(NSDictionary *resultDic) {
            
            if (SuccessCode) {
                [MBProgressHUD showMessage:ShowToast];
                if (self.successBlock) {
                    self.successBlock(self.accountTF.text, self.passwordTF1.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [MBProgressHUD showError:ShowToast];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *description) {
            [MBProgressHUD showError:description];
        }];
    }
    else{
        NSDictionary *paramDict = @{
                                    @"telephone":self.accountTF.text,
                                    @"userCode":@"",
                                    @"password":self.passwordTF1.text,
                                    @"repassword":self.passwordTF2.text,
                                    @"phoneCode":self.codeTF.text,
                                    };

        [[ZJNetworkManager shareNetworkManager] POSTWithURL:URL_updateLoginPassword Parameter:paramDict success:^(NSDictionary *resultDic) {

            if (SuccessCode) {
                [MBProgressHUD showMessage:ShowToast];
                if (self.successBlock) {
                    self.successBlock(self.accountTF.text, self.passwordTF1.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [MBProgressHUD showError:ShowToast];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *description) {
            [MBProgressHUD showError:description];
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    NSUInteger textLength = textField.text.length;
    NSUInteger replaceStrLength = string.length;
    
    NSMutableString *text = [NSMutableString stringWithString:textField.text];
    [text replaceCharactersInRange:range withString:string];
    [self canConfirm];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self canConfirm];
}


- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    if ([textField isEqual:self.passwordTF1]) {
        UIImageView *passwordImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
        passwordImageV.contentMode = UIViewContentModeCenter;
        if (textField.text.length == 0) {
            passwordImageV.image = [UIImage imageNamed:@"icon_pwd_default"];
        }
        else{
            passwordImageV.image = [UIImage imageNamed:@"icon_pwd_success"];
        }
        self.passwordTF1.leftView = passwordImageV;
    }
    else if ([textField isEqual:self.passwordTF2]){
        UIImageView *passwordImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, XXAutoLayout(27 + 8), XXAutoLayout(34))];
        passwordImageV.contentMode = UIViewContentModeCenter;
        
        if (textField.text.length == 0) {
            passwordImageV.image = [UIImage imageNamed:@"icon_pwd_default"];
        }
        else if ([textField.text isEqualToString:self.passwordTF1.text]){
            passwordImageV.image = [UIImage imageNamed:@"icon_pwd_success"];
        }
        else{
            passwordImageV.image = [UIImage imageNamed:@"icon_pwd_erro"];
        }
        self.passwordTF2.leftView = passwordImageV;
    }
    
}


#pragma mark - Other
- (void)canConfirm{
    if (self.accountTF.text.length && self.codeTF.text.length && self.passwordTF1.text.length && [self.passwordTF2.text isEqualToString:self.passwordTF1.text]) {
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
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF = [[UITextField alloc] init];
    }
    return _accountTF;
}

- (UITextField *)codeTF{
    if (!_codeTF) {
        _codeTF = [[UITextField alloc] init];
    }
    return _codeTF;
}

- (UITextField *)passwordTF1{
    if (!_passwordTF1) {
        _passwordTF1 = [[UITextField alloc] init];
    }
    return _passwordTF1;
}

- (UITextField *)passwordTF2{
    if (!_passwordTF2) {
        _passwordTF2 = [[UITextField alloc] init];
    }
    return _passwordTF2;
}

- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _codeBtn;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _loginBtn;
}


@end
