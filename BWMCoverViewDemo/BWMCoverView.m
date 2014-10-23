//
//  BWMCoverView.m
//  BWMCoverViewDemo
//
//  Created by 伟明 毕 on 14-10-19.
//  Copyright (c) 2014年 BWM. All rights reserved.
//

#import "BWMCoverView.h"

@interface UIImageView(BWMImage)

- (void)setImageWithURLString:(NSString *)urlString placeholderImageNamed:(NSString *)placeholderImageNamed;

@end

@implementation UIImageView(BWMImage)

- (void)setImageWithURLString:(NSString *)urlString placeholderImageNamed:(NSString *)placeholderImageNamed
{
    self.image = [UIImage imageNamed:placeholderImageNamed];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        if (imageData.length>0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                    self.alpha = 0.0;
                } completion:^(BOOL finished) {
                    if (finished) {
                        self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);
                        self.image = [UIImage imageWithData:imageData];
                        [UIView animateWithDuration:0.2 animations:^{
                            self.alpha = 1.0;
                            self.transform = CGAffineTransformIdentity;
                        }];
                    }
                }];
            });
        }
    });
}

@end

@interface BWMCoverView()
{
    NSTimer *_timer;
    NSTimeInterval _second;
}

@end

@implementation BWMCoverView

- (id)initWithModels:(NSArray *)models andFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame]) {
        self.models = models;
        self.animationOption = 0 << 20;
        [self createUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

+ (id)coverViewWithModels:(NSArray *)models andFrame:(CGRect)frame andPlaceholderImageNamed:(NSString *)placeholderImageNamed andClickdCallBlock:(void (^)(NSInteger index))callBlock
{
    BWMCoverView *coverView = [[BWMCoverView alloc] initWithModels:models andFrame:frame];
    coverView.placeholderImageNamed = placeholderImageNamed;
    coverView.callBlock = callBlock;
    [coverView updateView];
    return coverView;
}

// 创建UI
- (void)createUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
    _pageControl.userInteractionEnabled = YES;
    _pageControl.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    [self addSubview:_pageControl];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-20, self.frame.size.width-10, 20)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:_titleLabel];
    
}

// 更新视图
- (void)updateView
{
    _scrollView.contentSize = CGSizeMake((_models.count+2)*_scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    // 清除所有滚动视图
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    BWMCoverViewModel *model = nil;
    for (int i = 0; i<_models.count+2; i++) {
        if (i == 0) {
            model = [_models lastObject];
        } else if(i == _models.count+1) {
            model = [_models firstObject];
        } else {
            model = [_models objectAtIndex:i-1];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i-1;
        
        // 默认执行SDWebImage的缓存方法
        if ([imageView respondsToSelector:@selector(setImageWithURL:placeholderImage:)]) {
            [imageView performSelector:@selector(setImageWithURL:placeholderImage:) withObject:[NSURL URLWithString:model.imageURLString] withObject:[UIImage imageNamed:_placeholderImageNamed]];
        }
        else
        {
            [imageView setImageWithURLString:model.imageURLString placeholderImageNamed:_placeholderImageNamed];
        }
        [_scrollView addSubview:imageView];
        
        if (i>0 &&i<_models.count+1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
            [imageView addGestureRecognizer:tap];
        }
    }
    
    // 设置titleLabel和pageControl的相关内容数据
    if (_models.count>0) {
        _titleLabel.text = ((BWMCoverViewModel *)_models[0]).imageTitle;

        _pageControl.numberOfPages = _models.count;
        [_pageControl addTarget:self action:@selector(pageControlClicked:) forControlEvents:UIControlEventValueChanged];
    }
    
    // 先执行一次这个方法
    if (_scrollViewCallBlock != nil)
    {
        _scrollViewCallBlock(0);
    }
}

// 图片轻敲手势事件
- (void)imageViewClicked:(UITapGestureRecognizer *)recognizer
{
    NSInteger index = recognizer.view.tag;
    if (_callBlock != nil) {
        _callBlock(index);
    }
}

// pageControl修改事件
- (void)pageControlClicked:(UIPageControl *)pageControl
{
    [self scrollViewScrollToPageIndex:pageControl.currentPage+1];
}

// 设置自动播放
- (void)setAutoPlayWithDelay:(NSTimeInterval)second
{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    
    _second = second;
    _timer = [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(scrollViewAutoScrolling) userInfo:nil repeats:YES];
}

// 暂停或开启自动播放
- (void)stopAutoPlayWithBOOL:(BOOL)isStopAutoPlay
{
    if (_timer) {
        if (isStopAutoPlay) {
            [_timer invalidate];
        } else {
            _timer = [NSTimer scheduledTimerWithTimeInterval:_second target:self selector:@selector(scrollViewAutoScrolling) userInfo:nil repeats:YES];
        }
    }
}

// 自动滚动
- (void)scrollViewAutoScrolling
{
    CGPoint point;
    point = _scrollView.contentOffset;
    point.x += _scrollView.frame.size.width;
    
    [self animationScrollWithPoint:point];
}

// 滚动到指定的页面
- (void)scrollViewScrollToPageIndex:(NSInteger)page
{
    CGPoint point;
    point = CGPointMake(_scrollView.frame.size.width*page, 0);
    
    [self animationScrollWithPoint:point];
}

// 滚动到指点的point
- (void)animationScrollWithPoint:(CGPoint)point
{
    // 判断是否是需要动画
    if (_animationOption != 0 << 20) {
        _scrollView.contentOffset = point;
        [self scrollViewDidEndDecelerating:_scrollView];
        [UIView transitionWithView:_scrollView duration:0.7 options:_animationOption animations:nil completion:nil];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = point;
        }completion:^(BOOL finished) {
            if (finished) {
                [self scrollViewDidEndDecelerating:_scrollView];
            }
        }];
    }
}


- (void)setScrollViewCallBlock:(void (^)(NSInteger index))scrollViewCallBlock
{
    _scrollViewCallBlock = [scrollViewCallBlock copy];
    _scrollViewCallBlock(0);
}

#pragma mark-
#pragma mark- UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止自动播放
    if ([_timer isValid]) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 设置伪循环滚动
    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width-2*scrollView.frame.size.width, 0);
        
    } else if(scrollView.contentOffset.x >= scrollView.contentSize.width-scrollView.frame.size.width) {
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    }
    
    int currentPage = scrollView.contentOffset.x/self.frame.size.width-1;
    _pageControl.currentPage = currentPage;
    
    // 设置titleLabel
    if (_models.count>0) {
        _titleLabel.text = ((BWMCoverViewModel *)_models[currentPage]).imageTitle;
    }
    
    // 恢复自动播放
    if ([_timer isValid]) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_second]];
    }
    
    if(_scrollViewCallBlock != nil)
    {
        _scrollViewCallBlock(currentPage);
    }
}

@end