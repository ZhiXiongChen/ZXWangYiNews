//
//  ZXNews.h
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXNews : NSObject
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * digest;
@property (nonatomic,copy)NSString * replyCount;
@property (nonatomic,copy)NSString * imgsrc;
@property (nonatomic,copy)NSString * source;
@property (nonatomic,copy)NSArray * imgextra;
@property (nonatomic,copy)NSString * docid;
@property (nonatomic,assign)BOOL  imgType;
-(instancetype)initWithDitc:(NSDictionary *)dict;
+(instancetype)newsWithDict:(NSDictionary *)dict;
//发送异步请求获取数据然后字典转模型
+(void)newsListWithURLString:(NSString *)urlString success:(void(^)(NSArray *array))successBlock error:(void(^)(NSError *error))errorBlock;
@end
