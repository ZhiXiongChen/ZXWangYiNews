//
//  ZXNewsController.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/20.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXNewsController.h"
#import "ZXNews.h"
#import "ZXNewsCell.h"
#import "ZXWebController.h"
@interface ZXNewsController ()
@property (nonatomic,strong)NSArray * newsList;
@end

@implementation ZXNewsController
//重写Set方法刷新下tableView因为是异步请求
-(void)setNewsList:(NSArray *)newsList
{
    _newsList=newsList;
    [self.tableView reloadData];
}
//重写set方法获取
-(void)setUrlString:(NSString *)urlString
{
    _urlString=urlString;
    //异步加载数据
    [ZXNews newsListWithURLString:self.urlString success:^(NSArray *array) {
        //解决重用的问题，因为网速比较慢的时候可能会出现问题，这里赋值为空，在数据源方法重用的时候也为空
        self.newsList=nil;
        self.newsList=array;
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//在viewDidload的时候还没有拿到urlString
- (void)viewDidLoad {
    [super viewDidLoad];
   
}
//返回不同行的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXNews * model=self.newsList[indexPath.row];
    //返回相应的高度
    return [ZXNewsCell getRowHeight:model];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXNews *news=self.newsList[indexPath.row];
    ZXNewsCell * cell=[tableView dequeueReusableCellWithIdentifier:[ZXNewsCell getReuseId:news]];
    cell.news=news;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXNews * model=self.newsList[indexPath.row];
    ZXWebController * vc=[[ZXWebController alloc]init];
    vc.docid=model.docid;
    UINavigationController * nav=[self navigationController];
    [nav pushViewController:vc animated:YES];
}
-(UINavigationController * )navigationController{
    
    UIResponder * next = [self nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[UINavigationController class]]){
            return (UINavigationController * )next;
        }
        next = [next nextResponder];
    }
    return nil;
}
-(void)dealloc
{
    NSLog(@"dealloc");
}
@end
