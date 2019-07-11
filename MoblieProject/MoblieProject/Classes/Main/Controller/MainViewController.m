//
//  MainViewController.m
//  MoblieProject
//
//  Created by 火豹科技 on 2017/12/27.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"首页";
    self.view.backgroundColor = kColor_Red;
    self.tableView.backgroundColor = kColor_Red;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
