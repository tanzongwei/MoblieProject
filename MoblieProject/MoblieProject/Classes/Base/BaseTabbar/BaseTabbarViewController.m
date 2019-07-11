//
//  BaseTabbarViewController.m
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "BaseTabbarViewController.h"

#import "TransitionAnimation.h"
#import "TransitionController.h"

#import "MainViewController.h"
#import "RoomManagerViewController.h"
#import "MineViewController.h"

@interface BaseTabbarViewController ()
<UITabBarControllerDelegate>

/** 拖动手势 */
@property (nonatomic,strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    [self setTabbarComfig];
    
    [self addChildCtrl:[[MainViewController alloc] init] title:@"加入房间" image:@"joinRoom_text" selectedImage:@"joinRoom_text"];
    [self addChildCtrl:[[RoomManagerViewController alloc] init] title:@"创建房间" image:@"createRoom_text" selectedImage:@"createRoom_text"];
    [self addChildCtrl:[[MineViewController alloc] init] title:@"我的" image:@"createRoom_text" selectedImage:@"createRoom_text"];
}

-(void)setTabbarComfig {
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[BaseSetting shareInstance].tabbarItemNormalColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:[BaseSetting shareInstance].tabbarItemSelectColor,NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    [self.tabBar setBackgroundColor:[BaseSetting shareInstance].tabbarBgColor];
}

-(void)addChildCtrl:(UIViewController *)childCtrl
              title:(NSString *)title
              image:(NSString *)image
      selectedImage:(NSString *)selectedImage
{
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:childCtrl];
    [self addChildCtrlNav:nav title:title image:image selectedImage:selectedImage];
}
-(void)addChildCtrlNav:(UINavigationController *)childCtrlNav
                 title:(NSString *)title
                 image:(NSString *)image
         selectedImage:(NSString *)selectedImage
{
    childCtrlNav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childCtrlNav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childCtrlNav.title = title;
    [self addChildViewController:childCtrlNav];
}

#pragma mark -- 滑动手势
- (UIPanGestureRecognizer *)panGestureRecognizer{
    if (_panGestureRecognizer == nil){
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    }
    return _panGestureRecognizer;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    if (self.transitionCoordinator) {
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged){
        [self beginInteractiveTransitionIfPossible:pan];
    }
}

- (void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender{
    CGPoint translation = [sender translationInView:self.view];
    if (translation.x > 0.f && self.selectedIndex > 0) {
        self.selectedIndex --;
    }
    else if (translation.x < 0.f && self.selectedIndex + 1 < self.viewControllers.count) {
        self.selectedIndex ++;
    }
    else {
        if (!CGPointEqualToPoint(translation, CGPointZero)) {
            sender.enabled = NO;
            sender.enabled = YES;
        }
    }
    
    [self.transitionCoordinator animateAlongsideTransitionInView:self.view animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if ([context isCancelled] && sender.state == UIGestureRecognizerStateChanged){
            [self beginInteractiveTransitionIfPossible:sender];
        }
    }];
}

#pragma mark -- TabbarDelgate
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    // 打开注释 可以屏蔽点击item时的动画效果
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSArray *viewControllers = tabBarController.viewControllers;
        if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
            return [[TransitionAnimation alloc] initWithTargetEdge:UIRectEdgeLeft];
        }
        else {
            return [[TransitionAnimation alloc] initWithTargetEdge:UIRectEdgeRight];
        }
    }
    else{
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        return [[TransitionController alloc] initWithGestureRecognizer:self.panGestureRecognizer];
    }
    else {
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
