//
//  BannerModel.h
//  Toilet
//
//  Created by 覃木春 on 2019/3/21.
//  Copyright © 2019 MM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : NSObject

@property(strong,nonatomic)NSString *bannerId;
@property(strong,nonatomic)NSString *content;
@property(strong,nonatomic)NSString *createDate;
@property(assign,nonatomic)NSString *html;
@property(strong,nonatomic)NSString *source;
@property(strong,nonatomic)NSString *title;

@end

NS_ASSUME_NONNULL_END
