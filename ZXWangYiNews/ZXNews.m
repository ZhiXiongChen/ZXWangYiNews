//
//  ZXNews.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXNews.h"
#import "ZXNetworkTools.h"
@implementation ZXNews
-(instancetype)initWithDitc:(NSDictionary *)dict
{
    if(self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)newsWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDitc:dict];
}
//防止获取到的数据多于模型中的属性报错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
//发送异步请求获取数据然后字典转模型
+(void)newsListWithURLString:(NSString *)urlString success:(void(^)(NSArray *array))successBlock error:(void(^)(NSError *error))errorBlock
{
    [[ZXNetworkTools sharedManager]GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        //获取第一个键，因为第一个键可能是变化的
        NSString * rootKey=responseObject.keyEnumerator.nextObject;
        NSArray * array=responseObject[rootKey];
        //字典转模型
        NSMutableArray * arrayM=[NSMutableArray arrayWithCapacity:10];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZXNews * model=[self newsWithDict:obj];
                [arrayM addObject:model];
        }];
        if(successBlock)
        {
            successBlock(arrayM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error)
        {
            errorBlock(error);
        }
        
    }];
}
@end
