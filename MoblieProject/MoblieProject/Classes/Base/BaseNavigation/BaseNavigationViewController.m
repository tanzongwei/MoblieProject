//
//  BaseNavigationViewController.m
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()
<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

/** 当前 controller */
@property(nonatomic,weak) UIViewController * currentShowVC;

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(id)initWithRootViewController:(UIViewController *)rootViewController {
    
    BaseNavigationViewController *nvc= [super initWithRootViewController:rootViewController];
    
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    
    return nvc;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController* )viewController animated:(BOOL)animated {
    
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden=YES;
    }else{
        self.tabBarController.tabBar.hidden=NO;
    }
    
    return [super popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 第一个 控制器 不需要隐藏tabbar
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.hidden=YES;
    }else{
        
        self.tabBarController.tabBar.hidden=NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 第一个 控制器 不需要隐藏tabbar
    if (self.viewControllers.count > 2) {
        
        [self.tabBarController.tabBar setHidden:YES];
    } else {
        
        [self.tabBarController.tabBar setHidden:NO];
    }
    
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
    return [super popToRootViewControllerAnimated:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.viewControllers.count > 1) {
        
        [self.tabBarController.tabBar setHidden:YES];
    } else {
        
        [self.tabBarController.tabBar setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
