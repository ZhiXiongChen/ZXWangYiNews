//
//  ZXNewsCell.h
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXNews;
@interface ZXNewsCell : UITableViewCell
@property (nonatomic,strong)ZXNews * news;
//根据imgType来判断可重用ID是否是大图
+(NSString *)getReuseId:(ZXNews *)news;
+(CGFloat)getRowHeight:(ZXNews *)news;
@end
