//
//  ZXWebController.m
//  ZXWangYiNews
//
//  Created by zhixiongchen on 2017/8/21.
//  Copyright © 2017年 zhixiongchen. All rights reserved.
//

#import "ZXWebController.h"
#import "ZXNetworkTools.h"
@interface ZXWebController ()
@property(nonatomic,strong)UIWebView * webview;
@end

@implementation ZXWebController
-(void)loadView
{
    self.webview=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view=self.webview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
  __block  NSString * title=@"标题";
  __block  NSString * time=@"";
  __block  NSString * body=@"内容";
    [[ZXNetworkTools sharedManager]GET:[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.docid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary *  responseObject) {
        //获取第一个key
        NSString * rootKey=responseObject.keyEnumerator.nextObject;
        NSDictionary * dict=responseObject[rootKey];
        //先从数据中获取
        title=dict[@"title"];
        time=dict[@"ptime"];
        body=dict[@"body"];
        //获取返回的图片，获取数组，包含了img的信息
        NSArray * array=dict[@"img"];
        [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //获取图片占位符
            NSString * ref=obj[@"ref"];
            //获取图片的地址
            NSString * src=obj[@"src"];
            //拼接下图片的详情
            NSString * img=[NSString stringWithFormat:@"<img src='%@' width='100%%'",src];
            body=[body stringByReplacingOccurrencesOfString:ref withString:img];
        }];
        //加载网页的模板
        NSString * path=[[NSBundle mainBundle]pathForResource:@"index.html" ofType:nil];
        NSData *data=[NSData dataWithContentsOfFile:path];
        NSString * html=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //做字符串的替换
        html =[html stringByReplacingOccurrencesOfString:@"@title" withString:title];
        html =[html stringByReplacingOccurrencesOfString:@"@time" withString:time];
        html =[html stringByReplacingOccurrencesOfString:@"@body" withString:body];
        [self.webview loadHTMLString:html baseURL:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
