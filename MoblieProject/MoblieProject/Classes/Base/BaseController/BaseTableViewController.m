//
//  BaseTableViewViewController.m
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@property (nonatomic,assign) UITableViewStyle style;

@end

@implementation BaseTableViewController

-(instancetype)initWithSytle:(UITableViewStyle)style {
    
    if (self = [super init]) {
        
        _style = style ? style : UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithViewS];
}

-(void)initWithViewS
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusAndNavBarH, kScreenWidth, kScreenHeight-kNavHAndTabBarHiddenH) style:_style];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(ios 11.0,*)) {
        tableView.sectionHeaderHeight = 0.0f;
        tableView.sectionFooterHeight = 0.0f;
    }

    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

-(void)setEmptyDelegate {
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

#pragma mark - ============tableView======================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

#pragma -mark创建表视图中有几个分区的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cell_Identifiter = @"Cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cell_Identifiter];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- DZNEmpty Delegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    
    return ([self internetConnection] == NO) ? YES :( (self.dataList.count) ? NO : YES);
}

//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    
    return YES;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *text = ([self internetConnection] == NO) ? @"没有网络~~" : @"没有任何信息~~";
    UIFont *font = [UIFont systemFontOfSize:15.0];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    return attStr;
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    return ([self internetConnection] == NO) ? [UIImage imageNamed:@"icon_error_network"] : [UIImage imageNamed:@"icon_error_network"];
}

//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    
    if ([self internetConnection] == NO) { //网络状态 NO
        [self tapEmptyImageInNotReachable];
    } else {
        [self tapEmptyImageInDataEmpty];
    }
}

-(void)tapEmptyImageInNotReachable {
    NSLog(@"没有网络");
}

-(void)tapEmptyImageInDataEmpty {
    NSLog(@"没有数据");
}

#pragma mark -- 设置Mj 刷新
-(void)setRefreshDelegate {
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [YPRefreshHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [weakSelf downRefreshimg];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    self.tableView.mj_footer = [YPRefreshFooter footerWithRefreshingBlock:^{
        
        _page ++ ;
        [weakSelf upRefreshing];
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
}

/** 下拉刷新 */
-(void)downRefreshimg {
    
    [self endRefreshing];
    [self.tableView reloadData];
}

/** 上拉加载 */
-(void)upRefreshing {
    
    [self endRefreshingMore];
    [self.tableView reloadData];
}

/** 结束刷新 */
-(void)endRefreshing {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/** 结束刷新 没有更多数据 */
-(void)endRefreshingMore {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark -- 懒加载
-(NSMutableArray *)dataList {
    
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
