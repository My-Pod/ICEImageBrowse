//
//  ICEPhotoBrowseView.m
//  Example
//
//  Created by WLY on 16/7/8.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICEImageBrowseView.h"
#import "ICEImageScrollerView.h"



static const CGFloat pagControl_H = 50;
static const CGFloat spacing = 30;


@interface ICEImageBrowseView ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    UICollectionView    *_collectionView;
}

@property (nonatomic, strong) UIPageControl *pagController;


@end

@implementation ICEImageBrowseView

//设置背景颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    [_collectionView setBackgroundColor:backgroundColor];
    
}

//设置数据源的同时刷新CollectionView 并设置pag
- (void)setDatasource:(NSArray *)datasource{
    _datasource = datasource;
    [self.collectionView reloadData];
    self.pagController.numberOfPages = _datasource.count;
}


- (UIPageControl *)pagController{
    
    if (!_pagController) {
        _pagController = [[UIPageControl alloc] init];
        _pagController.pageIndicatorTintColor = [UIColor whiteColor];
        _pagController.currentPageIndicatorTintColor = [UIColor blueColor];
        [_pagController addTarget:self action:@selector(p_handlePagControlACtion:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pagController];
    }
    return _pagController;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewLayout *layout = [self layout];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor darkTextColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
        [self addSubview:_collectionView];
        [self bringSubviewToFront:_pagController];
    }
    return _collectionView;
}

- (UICollectionViewLayout *)layout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    return layout;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    layout.itemSize = self.bounds.size;
    _pagController.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - spacing - pagControl_H, CGRectGetWidth(self.bounds), pagControl_H);
}

- (void)p_handlePagControlACtion:(UIPageControl *)pagControl{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pagControl.currentPage inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    UIView *scrollerView ;
    if ([[_datasource objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        scrollerView = [[ICEImageScrollerView alloc] initWithFrame:cell.bounds withPhotoUrl:_datasource[indexPath.row]];
    }else if([[_datasource objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]){
        scrollerView = [[ICEImageScrollerView alloc] initWithFrame:cell.bounds withPhotoImage:_datasource[indexPath.row]];
    }
    scrollerView.backgroundColor = [UIColor darkTextColor];
    [cell addSubview:scrollerView];
    self.pagController.currentPage = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:[ICEImageScrollerView class]]) {
            [view removeFromSuperview];
        }
    }
}




@end
