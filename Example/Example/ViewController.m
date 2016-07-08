//
//  ViewController.m
//  Example
//
//  Created by WLY on 16/7/7.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ViewController.h"
#import "ICEPhotoView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    ICEPhotoView *photoView = [[ICEPhotoView alloc] initWithFrame:self.view.bounds];
    [photoView setImageURL:@"http://img2.3lian.com/2014/c7/12/d/77.jpg"];
    [self.view addSubview:photoView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
