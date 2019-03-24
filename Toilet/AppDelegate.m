//
//  AppDelegate.m
//  Toilet
//
//  Created by 覃木春 on 2019/3/18.
//  Copyright © 2019 MM. All rights reserved.
//

#import "AppDelegate.h"
#import "LZXViewController.h"
#import "LoginVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "BannerModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [[ZJNetworkManager shareNetworkManager] POSTWithURL:URL_queryBanners Parameter:@{@"type":@(1)} success:^(NSDictionary *resultDic) {

        if (SuccessCode) {
            NSArray *data = resultDic[@"data"];
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            if (data && data.count) {
                for (NSDictionary *dic in data) {
                    BannerModel *model = [BannerModel mj_objectWithKeyValues:dic];
                    [dataArray addObject:model.source];
                }
                
                LZXViewController *view = [[LZXViewController alloc]init];
                
                view.dataArray = dataArray;
                
                self.window.rootViewController = view;
                [self.window makeKeyAndVisible];
            }
        }
        else{

            LoginVC *vc = [[LoginVC alloc] init];
            UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:vc];
            self.window.rootViewController = nvc;
            [self.window makeKeyAndVisible];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *description) {
        LoginVC *vc = [[LoginVC alloc] init];
        UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:vc];
        self.window.rootViewController = nvc;
        [self.window makeKeyAndVisible];
    }];
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.overrideKeyboardAppearance = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
