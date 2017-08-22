//
//  ZXChannel.h
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXChannel : NSObject
@property (nonatomic,copy)NSString * tname;
@property (nonatomic,copy)NSString * tid;
//根据tid拼接网址
@property (nonatomic,copy,readonly)NSString * urlString;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)channelWithDict:(NSDictionary *)dict;

//从本地加载json数据
+(NSArray *)channels;
@end
