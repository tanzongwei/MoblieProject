//
//  BaseColletionViewController.h
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseColletionViewController : BaseViewController
<UICollectionViewDelegate,UICollectionViewDataSource,
DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/** 页码 */
@property (nonatomic,assign) NSInteger     page;

/** flow */
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

/** item 尺寸 */
@property (nonatomic,assign) CGSize itemSize;

/** collectionView 列表 */
@property (nonatomic,strong) UICollectionView *collectionView;

/** 数据源 */
@property (nonatomic,copy) NSMutableArray *dataList;

#pragma mark -- 刷新
/** 设置Mj 刷新 */
-(void)setRefreshDelegate;

/** 下拉刷新 */
-(void)downRefreshimg;

/** 上拉加载 */
-(void)upRefreshing;

/** 结束刷新 */
-(void)endRefreshing;

/** 结束刷新 没有更多数据 */
-(void)endRefreshingMore;

#pragma mark -- 数据为空
/** 设置Table 数据为空 或者没有网络状态显示 */
-(void)setEmptyDelegate;

/** 在没有网络状态下点击图标
 *  需要重写
 */
-(void)tapEmptyImageInNotReachable;

/** 在有网络 没有有数据的状态下点击图标
 *  需要重写
 */
-(void)tapEmptyImageInDataEmpty;

@end
