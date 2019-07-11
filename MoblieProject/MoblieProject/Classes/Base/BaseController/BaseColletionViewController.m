//
//  BaseColletionViewController.m
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "BaseColletionViewController.h"

@interface BaseColletionViewController ()

@end

@implementation BaseColletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView Datasource Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

#pragma mark -- UICollectionView Delegte
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.itemSize;
}

//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    if (view == nil) {
        view = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    }
    
    return view;
}

-(void)setEmptyDelegate {
    
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
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
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [YPRefreshHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [weakSelf downRefreshimg];
    }];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    
    self.collectionView.mj_footer = [YPRefreshFooter footerWithRefreshingBlock:^{
        
        _page ++ ;
        [weakSelf upRefreshing];
    }];
    self.collectionView.mj_footer.automaticallyChangeAlpha = YES;
}

/** 下拉刷新 */
-(void)downRefreshimg {
    
    [self endRefreshing];
    [self.collectionView reloadData];
}

/** 上拉加载 */
-(void)upRefreshing {
    
    [self endRefreshingMore];
    [self.collectionView reloadData];
}

/** 结束刷新 */
-(void)endRefreshing {
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

/** 结束刷新 没有更多数据 */
-(void)endRefreshingMore {
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark -- 懒加载
-(NSMutableArray *)dataList {
    
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

#pragma mark -- flow
-(UICollectionViewFlowLayout *)flowLayout {
    
    if (_flowLayout == nil) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        //item行间距
        _flowLayout.minimumLineSpacing = 10;//默认10
        _flowLayout.minimumInteritemSpacing = 10;//默认10
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//默认竖直滚动
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);//边距屏幕宽
    }
    return _flowLayout;
}

-(UICollectionView *)collectionView {
    
    if (_collectionView == nil) {

        CGRect frame = CGRectMake(0, kStatusAndNavBarH, kScreenWidth, kScreenHeight - kNavHAndTabBarHiddenH);
        _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.layoutMargins = UIEdgeInsetsZero;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
