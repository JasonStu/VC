//
//  LZXViewController.h
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LZXViewController : BaseViewController

/**************** 存放图片的数组  *******************/
@property (nonatomic, strong) NSArray *dataArray;

/** 验证码按钮 */
@property (nonatomic, strong) UIButton *codeBtn;

@end
