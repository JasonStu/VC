//
//  RegisterVC.h
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^RegisterSuccessBlock)(NSString *account, NSString *password);

@interface RegisterVC : BaseViewController

@property (nonatomic, assign) NSInteger type;     // 1 注册 ； 2  找密码
@property (nonatomic, copy) RegisterSuccessBlock successBlock;

@end


