//
//  ZXHeadline.h
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/19.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHeadline : NSObject
@property(nonatomic,copy)NSString * imgsrc;
@property(nonatomic,copy)NSString * title;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)headlineWithDict:(NSDictionary *)dict;
//异步加载网络请求，获取数据，封装在这个类中字典转模型,参数用void,因为异步请求不知道什么时候完成所有不能用数组为返回值
+(void)headlineWithSuccess:(void(^)(NSArray * array))success error:(void(^)(NSError * err))error;
@end
