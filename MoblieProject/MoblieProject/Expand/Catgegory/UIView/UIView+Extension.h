//
//  Created by YunShangCompany on 2017/4/2.
//  Copyright © 2017年 HanYu. All rights reserved.
#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGSize size;

@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;


+ (instancetype)viewFromXIB;


-(void)removeAllSubviews;

@end
