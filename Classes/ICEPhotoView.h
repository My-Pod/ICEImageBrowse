//
//  ICEPhotoView.h
//  Example
//
//  Created by WLY on 16/7/1.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^TapBlock) ();


@interface ICEPhotoView : UIView
/**
 *  最大缩放值
 */
@property (nonatomic, assign) CGFloat maxZoomValue;
/**
 *  最小缩放值
 */
@property (nonatomic, assign) CGFloat minZoomValue;

- (instancetype)init __attribute__((unavailable("方法不可用,请用 - initWithFrame: ")));

/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  使用图片URL进行初始化
 */
-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl;

/**
 *  使用图片进行初始化
 */
-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image;

/**
 *  重新设置图片URL
 */
- (void)setImageURL:(NSString *)url;

/**
 *  重新设置图片
 */
- (void)setImage:(UIImage *)image;

/**
 *  点击图片的回调
 */
- (void)tapImageView:(TapBlock)tap;


@end
