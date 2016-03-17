//
//  ViewController.m
//  shoppingDetailEffect
//
//  Created by FangZhongli on 16/3/1.
//  Copyright © 2016年 chinasilex. All rights reserved.
//

#import "ViewController.h"

#import "UIView+Size.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UIView *_view;
    UIWebView *_webView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -200, self.view.frame.size.width, 230)];
    view.backgroundColor = [UIColor greenColor];
    [self.tableView addSubview:view];
    _view = view;
    [self.tableView sendSubviewToBack:view];
    
    for (int i=0; i<4; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+i*50, view.frame.size.width, 50)];
        lab.textColor = [UIColor whiteColor];
        lab.text = [NSString stringWithFormat:@"----%d----",i];
        lab.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lab];
    }
    
    self.tableView.tableFooterView = [UIView new];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.tableView.contentSize.height, self.view.frame.size.width, self.view.frame.size.height-50)];
    webView.backgroundColor = [UIColor magentaColor];
    webView.scalesPageToFit = YES;
    webView.scrollView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.tableView addSubview:webView];
    _webView = webView;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, -50)];
    lab.textColor = [UIColor whiteColor];
    lab.text = [NSString stringWithFormat:@"----下拉返回----"];
    lab.textAlignment = NSTextAlignmentCenter;
    [_webView.scrollView addSubview:lab];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView==self.tableView) {
//        if (scrollView.contentOffset.y<-200) {
//            _view.top = -200;
//        }else{
            _view.top = -200*3/5.0+scrollView.contentOffset.y*2/5.0;
//        }
        
        float maxOffset = MAX(30, self.tableView.contentSize.height-self.tableView.height+30);
        if (scrollView.contentOffset.y>maxOffset && !scrollView.isDragging && scrollView.decelerating) {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height-50) animated:YES];
            self.tableView.scrollEnabled = NO;
        }
    }
    if (scrollView==_webView.scrollView) {
        if (scrollView.contentOffset.y<-30 && !scrollView.isDragging && scrollView.decelerating) {
            [self.tableView setContentOffset:CGPointMake(0, -200) animated:YES];
            [_webView.scrollView setContentOffset:CGPointMake(0, 0)];
            self.tableView.scrollEnabled = YES;
        }
    }
}

#pragma mark - TableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    return view;
}


@end
