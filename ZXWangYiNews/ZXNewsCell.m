//
//  ZXNewsCell.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXNewsCell.h"
#import "ZXNews.h"
#import <UIImageView+AFNetworking.h>
@interface ZXNewsCell()
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextraViews;

@end
@implementation ZXNewsCell
//根据imgType来设置Cell的高度
+(CGFloat)getRowHeight:(ZXNews *)news
{
    if(news.imgType)
    {
        return 210;
    }
    else if (news.imgextra)
    {
        return 180;
    }
    return 90;

}
//根据返回的imgType属性来设置可重用ID
+(NSString *)getReuseId:(ZXNews *)news
{
    if(news.imgType)
    {
        return @"news_cell1";
    }
    else if(news.imgextra)
    {
        return @"news_cell2";
    }
        return @"news_cell";
}
-(void)setNews:(ZXNews *)news
{
    _news=news;
    [self.imgsrcView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    self.titleLabel.text=news.title;
    self.digestLabel.text=news.digest;
    self.replyCountLabel.text=[self setCount];
    self.sourceLabel.text=news.source;
    //遍历imgextra，从字典中获取图片的地址
    [news.imgextra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * imageSrc=obj[@"imgsrc"];
        //从集合中取图片
        UIImageView * imageView=self.imgextraViews[idx];
        //设置图片
        [imageView setImageWithURL:[NSURL URLWithString:imageSrc]];
    }];
}
-(NSString *)setCount
{
    CGFloat number;
    if([self.news.replyCount intValue]>=10000)
    {
        number=[self.news.replyCount intValue]*1.0/10000;
        return [NSString stringWithFormat:@"%.1f万跟帖",number];
    }
    else
    {
        number=[self.news.replyCount intValue];
       return [NSString stringWithFormat:@"%.0f跟帖",number];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //调整布局,防止去加载storyboard中的宽度
    [self.titleLabel layoutIfNeeded];
    //让titleLabel如果超过两行摘要就不显示，所以先计算title的长度，然后让title的长度去和titleLabel的长度进行判断
    CGFloat titleLength=[self.news.title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    if(titleLength>self.titleLabel.frame.size.width)
    {
        self.digestLabel.hidden=YES;
    }
    else
    {
        self.digestLabel.hidden=NO;
    }
}
@end
