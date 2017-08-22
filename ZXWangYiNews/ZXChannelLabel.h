//
//  ZXChannelLabel.h
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXChannelLabel : UILabel
+(instancetype)channelLabelWithTname:(NSString *)tname;
@property(nonatomic,assign)CGFloat scale;
@end
