//
//  ZXChannelLabel.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXChannelLabel.h"
#define kBIGFONT 18
#define kSMALLFONT 14
@implementation ZXChannelLabel
+(instancetype)channelLabelWithTname:(NSString *)tname
{
    ZXChannelLabel * label=[ZXChannelLabel new];
    label.text=tname;
    //让文字居中显示，因为label上面的文字会从大字体变成小字体
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:kBIGFONT];
    //把label的大小设置为自适应大字体的大小，因为字体会变大，如果按照小字体来的话，会超出这个size；
    [label sizeToFit];
    label.font=[UIFont systemFontOfSize:kSMALLFONT];
    return label;
}
//重写set方法改变比例大小
-(void)setScale:(CGFloat)scale
{
    CGFloat constant =kBIGFONT*1.0 / kSMALLFONT-1;
    self.transform=CGAffineTransformMakeScale(constant*scale+1, constant*scale+1);
    self.textColor=[UIColor colorWithRed:scale green:0 blue:0 alpha:1];
}
@end
