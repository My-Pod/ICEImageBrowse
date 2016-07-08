//
//  ICEPhotoBrowseView.h
//  Example
//
//  Created by WLY on 16/7/8.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICEImageScrollerView;
@interface ICEImageBrowseView : UIView

@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong, readonly) ICEImageScrollerView *scrollerView;
@property (nonatomic, strong, readonly) UIPageControl *pagController;


@end
