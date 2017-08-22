//
//  AppDelegate.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/19.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //显示加载网络的指示符
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    //设置缓存,都保存在imagesCache这个文件夹下面，当磁盘中设定的容量不够用了会自动清理前面的NSURLCache缓存了从服务器返回的NSURLResponse对象。它的默认配置只是缓存在内存并没有写到硬盘。
    NSURLCache * cache=[[NSURLCache alloc]initWithMemoryCapacity:1024*1024*5 diskCapacity:1024*1024*10 diskPath:@"imagesCache"];
    [NSURLCache setSharedURLCache:cache];
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
