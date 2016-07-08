//
//  ViewController.m
//  Example
//
//  Created by WLY on 16/7/7.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ViewController.h"
#import "ICEImageScrollerView.h"
#import "ICEImageBrowseView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    NSString *imgURL = @"http://piccdn.xingyun.cn/media/users/post/077/94/100200890354_779462_1010.";
    NSString *imgURL1 = @"http://piccdn.xingyun.cn/media/users/post/077/94/100200890354_779451_1010.jpg";
    NSString *imgURL2 = @"http://piccdn.xingyun.cn/media/users/post/077/94/100200890354_779449_1010.jpg";
    NSString *imgURL3 = @"http://piccdn.xingyun.cn/media/users/post/077/94/100200890354_779448_1010.jpg";
    
    NSArray *arr = @[imgURL, imgURL1, imgURL2, imgURL3];
    ICEImageBrowseView *browse = [[ICEImageBrowseView alloc] initWithFrame:self.view.bounds];
    browse.datasource = arr;
    
    [self.view addSubview:browse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
