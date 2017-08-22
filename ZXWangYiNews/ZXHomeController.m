//
//  ZXHomeController.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXHomeController.h"
#import "ZXChannel.h"
#import "ZXChannelLabel.h"
#import "ZXHomeCell.h"
@interface ZXHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
//记录当前label的索引
@property(nonatomic,assign)int currentIndex;
@property(nonatomic,assign)int complete;
@property (nonatomic,strong)NSArray * channels;
@end

@implementation ZXHomeController
-(NSArray *)channels
{
    if(!_channels)
    {
        _channels=[ZXChannel channels];
    }
    return _channels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载新闻的分类
    [self loadChannels];
    //设置样式
    [self setCollectionViewStyle];
}
//设置collectionView的样式
-(void)setCollectionViewStyle
{
    self.collectionView.pagingEnabled=YES;
    self.collectionView.bounces=NO;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    self.flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing=0;
    self.flowLayout.minimumInteritemSpacing=0;
}
//在控制器中如果出现了scrollView,系统会自动的加上64的间距
-(void)loadChannels
{
    //不让系统自动的生成64的偏移
    self.automaticallyAdjustsScrollViewInsets=NO;
    CGFloat marginX=5;
    CGFloat x=marginX;
    CGFloat y=0;
    for(int i=0;i<self.channels.count;i++)
    {
        ZXChannel * channel=self.channels[i];
        ZXChannelLabel * label=[ZXChannelLabel channelLabelWithTname:channel.tname];
        //设置label的frame
        CGFloat w=label.bounds.size.width;
        CGFloat h=label.bounds.size.height;
        label.frame=CGRectMake(x, y, w, h);
        x+=marginX+w;
        [self.scrollView addSubview:label];
        label.tag=i;
        label.userInteractionEnabled=YES;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollItem:)];
        [label addGestureRecognizer:tap];
        
    }
    self.scrollView.contentSize=CGSizeMake(x, 0);
    self.scrollView.showsHorizontalScrollIndicator=NO;
    //设置第一个label显示大字体和红色
    ZXChannelLabel * label=self.scrollView.subviews[0];
    label.scale=1;
    
}
//label的点击手势
-(void)scrollItem:(UITapGestureRecognizer *)tap
{
    NSIndexPath * indexPath=[NSIndexPath indexPathForItem:tap.view.tag inSection:0];
[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
     ZXChannelLabel * currentLabel=self.scrollView.subviews[self.currentIndex];
    ZXChannelLabel *nextLabel =self.scrollView.subviews[tap.view.tag];
    currentLabel.scale=0;
    nextLabel.scale=1;
    self.currentIndex=(int)tap.view.tag;
}
-(ZXChannelLabel * )label{
    
    UIResponder * next = [self nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[ZXChannelLabel class]]){
            return (ZXChannelLabel * )next;
        }
        next = [next nextResponder];
        NSLog(@"%@",next);
    }
    return nil;
}
//当计算完collectionView的大小的时候再去设置Cell的大小
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.flowLayout.itemSize=self.collectionView.bounds.size;
}
//设置数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXHomeCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"home_cell" forIndexPath:indexPath];
    ZXChannel * model=self.channels[indexPath.item];
    //把网址传给了cell
    cell.urlString=model.urlString;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //获取当前的label
    ZXChannelLabel * currentLabel=self.scrollView.subviews[self.currentIndex];
    //创建下一个label
    ZXChannelLabel * nextLabel=nil;
    for(NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems)
    {
        if(indexPath.item!=self.currentIndex)
        {
            nextLabel=self.scrollView.subviews[indexPath.item];
            break;
        }
    }
    if(nextLabel==nil)
    {
        return;
    }
    if(self.complete)
    {
        
        return;
    }
    else
    {
    //获取滚动的比例,通过偏移量来进行获取当前的页数减去现在的索引
    CGFloat nextScale=ABS(scrollView.contentOffset.x/scrollView.bounds.size.width -self.currentIndex);
    CGFloat currentScale=1-nextScale;
    //当我们滚动到下一页的时候可能会出现下一页的下一页也有部分出来了，那个时候nextScale就变成了>1，然后上面的可见的item也有出现下一页的下一页的那个item
    if(nextScale>1)
    {
        self.complete=1;
    }
    currentLabel.scale=currentScale;
    nextLabel.scale=nextScale;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前页的页数
    self.currentIndex=scrollView.contentOffset.x/scrollView.bounds.size.width;
    //居中的显示当前的标签
    ZXChannelLabel * label=self.scrollView.subviews[self.currentIndex];
    CGFloat offset=label.center.x-self.scrollView.bounds.size.width*0.5;
    //这里计算出来的其实相当于就是上一页最后一个label的x值，相当于ScrollView滚到最后的时候，滚到中间的时候就比maxoffset大了
    CGFloat maxoffset=self.scrollView.contentSize.width-label.bounds.size.width-self.scrollView.bounds.size.width;
    if(offset<0)
    {
        offset=0;
    }
    else if(offset>maxoffset)
    {
        offset=maxoffset+label.bounds.size.width;
    }
    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
     self.complete=0;
}
@end
