//
//  ZXChannel.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXChannel.h"

@implementation ZXChannel
-(NSString *)urlString
{
    return [NSString stringWithFormat:@"article/headline/%@/0-140.html",self.tid];
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
+(instancetype)channelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
//从本地加载json数据
+(NSArray *)channels
{
    NSString * path=[[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    //转换成二进制数据
    NSData * data=[NSData dataWithContentsOfFile:path];
    //进行json的反序列化
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //取出数组
    NSArray * array=dict[@"tList"];
    NSMutableArray * arrayM=[NSMutableArray arrayWithCapacity:10];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZXChannel * model=[ZXChannel channelWithDict:obj];
        [arrayM addObject:model];
    }];
    return [arrayM sortedArrayUsingComparator:^NSComparisonResult(ZXChannel * obj1, ZXChannel * obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
}
@end
