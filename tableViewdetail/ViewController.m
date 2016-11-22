//
//  ViewController.m
//  tableViewdetail
//
//  Created by ekhome on 16/11/22.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 60)];
    [btn setTitle:@"点击我条转界面回传值" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)action{
    [self presentViewController:[TableViewController new] animated:YES completion:^{
        NSLog(@"我推出去了");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
