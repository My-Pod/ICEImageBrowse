//
//  ICEPhotoView.m
//  Example
//
//  Created by WLY on 16/7/1.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEPhotoView.h"
#import "UIImageView+WebCache.h"


@interface ICEPhotoView ()<UIScrollViewDelegate>
{
    UIScrollView            *_scrollView;
    UIActivityIndicatorView *_waitView; //等待加载视图
    UIView                  *_waitViewBackView;//等待加载的背景视图
    UIImageView             *_imageView;
}
@property(nonatomic, copy) TapBlock tapBlock;


@end

@implementation ICEPhotoView




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_initConfig];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_initConfig];
        [self setImageURL:photoUrl];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_initConfig];
        _imageView.image = image;
    }
    return self;
}


- (void)setImageURL:(NSString *)url{

    if (!_waitView) {
        
        _waitViewBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _waitView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _waitView.transform = CGAffineTransformMakeScale(2.0, 2.0);
        _waitView.center = _imageView.center;
        [_waitView hidesWhenStopped];
        [_imageView addSubview:_waitView];
    }
    
    [_waitView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [_waitView stopAnimating];
            
            if (error) {
                _imageView.image = [UIImage imageNamed:@"faileImage"];
            }else{
                _imageView.image = image;
            }
            
        }];
    });
    
}

- (void)setImage:(UIImage *)image{
    _imageView.image = image;
}


/**
 *  初始化
 */
- (void)p_initConfig{
    //添加scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 3;
    _scrollView.backgroundColor = [UIColor darkTextColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    //添加图片
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_imageView];
    
    
    
    //添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    doubleTap.numberOfTapsRequired = 2;//需要点两下
    twoFingerTap.numberOfTouchesRequired = 2;//需要两个手指touch
    
    [_imageView addGestureRecognizer:singleTap];
    [_imageView addGestureRecognizer:doubleTap];
    [_imageView addGestureRecognizer:twoFingerTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];//如果双击了，则不响应单击事件
    
    
    [_scrollView setZoomScale:1];
    
}




#pragma mark - UIScrollViewDelegate
//scroll view处理缩放和平移手势，必须需要实现委托下面两个方法,另外 maximumZoomScale和minimumZoomScale两个属性要不一样
//1.返回要缩放的图片
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
//2.重新确定缩放完后的缩放倍数
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}


#pragma mark - 图片的点击，touch事件
-(void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer{
//    NSLog(@"单击");
    if (gestureRecognizer.numberOfTapsRequired == 1) {
        if (self.tapBlock) {
            self.tapBlock();
            _tapBlock = nil;
        }
    }
}

- (void)tapImageView:(TapBlock)tap{
    self.tapBlock = tap;
}

-(void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
//    NSLog(@"双击");
    if (gestureRecognizer.numberOfTapsRequired == 2) {
        if(_scrollView.zoomScale == 1){
            float newScale = [_scrollView zoomScale] *2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }else{
            float newScale = [_scrollView zoomScale]/2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }
    }
}

-(void)handleTwoFingerTap:(UITapGestureRecognizer *)gestureRecongnizer{
//    NSLog(@"2手指操作");
    float newScale = [_scrollView zoomScale]/2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecongnizer locationInView:gestureRecongnizer.view]];
    [_scrollView zoomToRect:zoomRect animated:YES];
}


#pragma mark - 缩放大小获取方法
-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    //大小
    zoomRect.size.height = [_scrollView frame].size.height/scale;
    zoomRect.size.width = [_scrollView frame].size.width/scale;
    //原点
    zoomRect.origin.x = center.x - zoomRect.size.width/2;
    zoomRect.origin.y = center.y - zoomRect.size.height/2;
    return zoomRect;
}




@end

