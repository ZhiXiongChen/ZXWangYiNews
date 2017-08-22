//
//  ZXImageLoopController.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/19.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXImageLoopController.h"
#import "ZXHeadline.h"
#import "ZXCollectionImageCell.h"
@interface ZXImageLoopController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)NSArray * imageItems;
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation ZXImageLoopController
//在使用collectionView的时候我们必须要设置flowLayout
//必须去注册Cell,可以从sb中加载也可以代码注册，也可以加载nib
-(void)viewDidLoad
{
    [super viewDidLoad];
    //加载数据
    [ZXHeadline headlineWithSuccess:^(NSArray *array) {
        self.imageItems=array;
    } error:^(NSError *err) {
        NSLog(@"%@",err);
    }];
   
    //设置样式
    [self setCollectionViewStyle];
}
//设置collectionView的样式
-(void)setCollectionViewStyle
{
    //这里设置itemSize的大小还是storyboard中加载的还是高度还是667，所以我们在一个适当的位置当tableViewController的containerView对collectionView的约束产生之后再去设置
   //self.flowLayout.itemSize=self.collectionView.frame.size;
    //行的间距
    self.flowLayout.minimumLineSpacing=0;
    //item之间的间距
    self.flowLayout.minimumInteritemSpacing=0;
    //取消弹簧效果
    self.collectionView.bounces=NO;
    //取消水平滚动条
    self.collectionView.showsHorizontalScrollIndicator=NO;
    //设置分页效果
    self.collectionView.pagingEnabled=YES;
    //设置水平滚动的效果
    self.flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //等待collectionView的大小重新计算之后，再设置cell的大小
    self.flowLayout.itemSize=self.collectionView.bounds.size;
}
//重写Set方法，在加载完毕赋值的时候刷新collectionView
-(void)setImageItems:(NSArray *)imageItems
{
    _imageItems = imageItems;
    //重新加载
    [self.collectionView reloadData];
    //先去滚动到第2个cell的位置
//    NSIndexPath * indexPath=[NSIndexPath indexPathForItem:1 inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}
//设置数据源的方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageItems.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //从缓存池中去找
   ZXCollectionImageCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"headline_cell"forIndexPath:indexPath];
    //在滚动的过程中indexPath.item的只可能是0或者2
//  NSInteger index = (self.currentIndex + self.page - 1 + self.imageItems.count) % self.imageItems.count;
      //传给pageControl当前的item到第几个了
    cell.tag = indexPath.item;
    cell.headline = self.imageItems[indexPath.item];
    return cell;
}
//当滚动结束之后，把cell换成第二个cell
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算下一张图片的索引就是+1或者-1
    //我们先计算下屏幕的偏移量，从左往右翻也就是上一页的话滑到的item是0.所以计算出来的就为0，如果从右往左翻也就是下一页，滑到的item就为2，所以计算出来的也就为2，所以我们图片的索引就可以算了，也就是说下面self.currentIndex刚开始是0，然后如果下一张的话，self.currentIndex就变成了1，如果上一张的话
//    int offset=(scrollView.contentOffset.x/scrollView.bounds.size.width)-1;
//    self.currentIndex=(self.currentIndex+offset+self.imageItems.count)%self.imageItems.count;
//    
//    //始终滚动到第2个cell的位置
//    NSIndexPath * indexPath=[NSIndexPath indexPathForItem:1 inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}
@end
