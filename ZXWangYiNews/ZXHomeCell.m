//
//  ZXHomeCell.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXHomeCell.h"
#import "ZXNewsController.h"
@interface ZXHomeCell()

@property(nonatomic,strong)ZXNewsController * newsController;
@end
@implementation ZXHomeCell
//当cell加载xib或者sb完成之后调用我们可以在这里设置cell的内容
-(void)awakeFromNib
{
    [super awakeFromNib];
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"News" bundle:nil];
    //如果这里直接设置的话，方法执行完，vc就释放了，所以我们就无法设置请求了，这个时候view的大小是有问题的
    self.newsController=[sb instantiateInitialViewController];
    [self.contentView addSubview:self.newsController.view];
}
//当cell的大小知道以后，让控制器的大小和cell的大小一样
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.newsController.view.frame=self.bounds;
}
-(void)setUrlString:(NSString *)urlString
{
    _urlString=urlString;
    //要把urlString给控制器，因为在awakeFromNib中还没有urlString
    self.newsController.urlString=urlString;
}
@end
