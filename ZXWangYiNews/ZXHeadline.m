//
//  ZXHeadline.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/19.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXHeadline.h"
#import "ZXNetworkTools.h"
@implementation ZXHeadline
//对象方法
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
//类方法
+(instancetype)headlineWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
//因为返回的数据比我们的模型的属性多，所以我们要重写下一个方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
+(void)headlineWithSuccess:(void (^)(NSArray *))success error:(void (^)(NSError * err))error
{
    [[ZXNetworkTools sharedManager]GET:@"ad/headline/0-4.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        
        //如果第一个键是变化的，我们就要用字典的一个属性去获取第一个键，而不是直接用名字去取了,responseObject.keyEnumerator默认是不指向任何键的指向第一个键之前，所以用nextObject来获取第一个键
        NSString * firstKey=responseObject.keyEnumerator.nextObject;
        NSArray * array=responseObject[firstKey];
        NSMutableArray * arrayM=[NSMutableArray arrayWithCapacity:4];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXHeadline * model=[ZXHeadline headlineWithDict:obj];
            [arrayM addObject:model];
        }];
        if(success)
        {
            success(arrayM.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull er) {
        //产生错误的时候回调error的block，在控制器中给error赋值，然后发生错误的时候调用赋值的那些语句
        if(error)
        {
            error(er);
        }
    }];
    
}
@end
