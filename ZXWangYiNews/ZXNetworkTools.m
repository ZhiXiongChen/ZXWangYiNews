//
//  ZXNetworkTools.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/19.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXNetworkTools.h"

@implementation ZXNetworkTools
+(instancetype)sharedManager
{
    static id instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //写一个基地址，这样之后发送get请求只用写这个基地址之后的字符就可以了，因为我们这里只访问一个服务器，http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html 和http://c.m.163.com/nc/ad/headline/0-4.html，前面部分是一样的。
        NSURL * baseURL=[NSURL URLWithString:@"http://c.m.163.com/nc/"];
        NSURLSessionConfiguration * configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        //设置超时时长
        configuration.timeoutIntervalForRequest=15;
        instance=[[self alloc]initWithBaseURL:baseURL sessionConfiguration:configuration];
    });
    return instance;
}
@end
