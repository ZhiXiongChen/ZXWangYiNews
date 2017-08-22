//
//  ZXNetworkTools.h
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/19.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZXNetworkTools : AFHTTPSessionManager
+(instancetype)sharedManager;
@end
