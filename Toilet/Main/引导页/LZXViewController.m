//
//  LZXViewController.m
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import "LZXViewController.h"
#import "LZXCollectionViewCell.h"
#import "LoginVC.h"
#import "SimpleWebVC.h"

@interface LZXViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *collectionV;
    NSMutableArray *marray;
    NSMutableArray *marrayURL;
}

@end

@implementation LZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionView];
    
    [self.view addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(XXAutoLayout(85), XXAutoLayout(30)));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(XXAutoLayout(-120));
        make.right.mas_equalTo(self.view.mas_right).offset(XXAutoLayout(-20));
    }];
    
    [self startTime];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置cell 大小
    layout.itemSize = self.view.bounds.size;
    
    // 设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置间距
    layout.minimumLineSpacing = 0;
    
    collectionV = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionV.delegate = self;
    
    collectionV.dataSource = self;
    // 隐藏滚动条
    collectionV.showsHorizontalScrollIndicator = NO;
    
    // 设置分页效果
    collectionV.pagingEnabled = YES;
    
    //    // 设置弹簧效果
    //    collectionV.bounces =  NO;
    
    [self.view addSubview:collectionV];
    
    [collectionV registerClass:[LZXCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return marrayURL?marrayURL.count:self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LZXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.imageviewbg.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    

    [cell.imageviewbg sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row]]];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count - 1) {
        
//        [self judgeToSkip];
    }else{
        
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float contentNum = scrollView.contentOffset.x / XX_SCREEN_WIDTH;
    if (contentNum > self.dataArray.count - 1) {
//        [self judgeToSkip];
    }
}

-(void)startTime{
    __block NSInteger timeout= 5; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self judgeToSkip];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:[NSString stringWithFormat:@"跳过%zd秒",timeout--] forState:UIControlStateNormal];
                [UIView commitAnimations];

            });
        }
    });
    dispatch_resume(_timer);
}

-(void)judgeToSkip{

    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    if (str) {
        UIWindow * window = [[UIApplication sharedApplication].delegate window];

        SimpleWebVC *webVC = [[SimpleWebVC alloc] init];
        webVC.htmlStr = [NSString stringWithFormat:@"http://ce.degjsm.com/phone/home/index.jhtml?usreCode=%@",str];
        //                [self.navigationController pushViewController:webVC animated:YES];
        window.rootViewController = webVC;
    }else{
        UIWindow * window = [[UIApplication sharedApplication].delegate window];
        LoginVC *vc = [[LoginVC alloc] init];
        UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:vc];
        window.rootViewController = nvc;
    }
    

}

- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.backgroundColor = RGBA(222, 222, 222, 1);
        [_codeBtn setTitleColor:RGBA(203, 78, 64, 1) forState:UIControlStateNormal];
        _codeBtn.layer.cornerRadius = XXAutoLayout(15);
        _codeBtn.titleLabel.font = XXFont(13);
        _codeBtn.layer.masksToBounds = YES;
        [_codeBtn addTarget:self action:@selector(judgeToSkip) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

@end
