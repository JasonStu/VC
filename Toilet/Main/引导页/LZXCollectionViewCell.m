//
//  LZXCollectionViewCell.m
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import "LZXCollectionViewCell.h"

@implementation LZXCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageviewbg = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:self.imageviewbg];
    }
    return self;
}

@end
