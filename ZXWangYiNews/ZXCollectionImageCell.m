//
//  ZXCollectionImageCell.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/19.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXCollectionImageCell.h"
#import "ZXHeadline.h"
#import <UIImageView+AFNetworking.h>
@interface ZXCollectionImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end
@implementation ZXCollectionImageCell
//重写Set方法
-(void)setHeadline:(ZXHeadline *)headline
{
    _headline=headline;
    //解决item重用的问题，因为图片和标题的加载也是需要时间的，所以先设置为空，再去加载
//    self.imageView.image=nil;
//    self.desLabel.text=nil;
    [self.imageView setImageWithURL:[NSURL URLWithString:headline.imgsrc]];
    self.desLabel.text=headline.title;
    self.pageControl.currentPage=self.tag;
}
@end
