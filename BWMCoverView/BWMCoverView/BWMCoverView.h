//
//  BWMCoverView.h
//  BWMCoverViewDemo
//
//  Created by 伟明 毕 on 14-10-19.
//  Copyright (c) 2014年 BWM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWMCoverViewModel.h"

// 加载前的本地图片占位符，此为图片文件名
#define BWMCoverViewDefaultImage @"BWMCoverViewDefaultLoadingImage"

/**
 * BWM出品的用于创建UIScrollView和UIPageControl的图片展示封面
 * 支持循环滚动，动画，异步加载图片
 * 依赖于SDWebImage
 */
@interface BWMCoverView : UIView <UIScrollViewDelegate>

// 主要的可视化控件
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *models; // 一个包含BWMCoverModel的数组
@property (nonatomic, copy) NSString *placeholderImageNamed; // 图片载入前的本地占位图片名字符串
@property (nonatomic, copy) void(^clickedCallBlock)(int); // 点击后的调用的block
@property (nonatomic, copy) void(^scrolledCallBlock)(int); // 视图滚动后回调的block
@property (nonatomic, assign) UIViewAnimationOptions animationOption; // 动画选项（可选）
@property (nonatomic, assign) UIViewContentMode imageViewsContentMode; // 图片的内容模式，默认为UIViewContentModeScaleToFill

/**
 *  快速创建BWMCoverView的工厂方法
 *
 *  @param models                一个包含BWMCoverModel的数组
 *  @param frame                 设置的frame
 *  @param placeholderImageNamed 图片加载前的本地占位图片名
 *  @param imageViewsContentMode 图片的内容模式 UIViewContentMode
 *  @param clickedCallBlock      点击后的调用的block
 *  @param scrolledCallBlock     视图滚动后回调的block
 *
 *  @return 返回BWMCoverView的对象指针
 */
+ (id)coverViewWithModels:(NSArray *)models andFrame:(CGRect)frame andPlaceholderImageNamed:(NSString *)placeholderImageNamed  andImageViewsContentMode:(UIViewContentMode) imageViewsContentMode andClickdCallBlock:(void (^)(int index))clickedCallBlock andScrolledCallBlock:(void(^)(int index))scrolledCallBlock;

/**
 *  修改BWMCoverView的参数后都要更新视图才能够正常使用
 */
- (void)updateView;

/**
 *  设置视图滚动到目标地址后回调的块
 *
 *  @param scrolledCallBlock 设置的块
 */
- (void)setScrolledCallBlock:(void (^)(int))scrolledCallBlock;

/**
 *  设置点击回调的块
 *
 *  @param clickedCallBlock 设置的块
 */
- (void)setClickedCallBlock:(void (^)(int))clickedCallBlock;

/**
 *  设置自动播放
 *
 *  @param second 每隔多少秒滚动一次
 */
- (void)setAutoPlayWithDelay:(NSTimeInterval)second;

/**
 *  停止或恢复自动播放（在设置了自动播放时才有效）
 *
 *  @param isStopAutoPlay 当为YES时，停止滚动；当为NO时，自动滚动。
 */
- (void)stopAutoPlayWithBOOL:(BOOL)isStopAutoPlay;

/**
 *  设置切换时的动画选项，不设置则默认为scrollView滚动动画
 *
 *  提供的动画类型有：
 *  - UIViewAnimationOptionTransitionNone
 *  - UIViewAnimationOptionTransitionFlipFromLeft
 *  - UIViewAnimationOptionTransitionFlipFromRight
 *  - UIViewAnimationOptionTransitionCurlUp
 *  - UIViewAnimationOptionTransitionCurlDown
 *  - UIViewAnimationOptionTransitionCrossDissolve
 *  - UIViewAnimationOptionTransitionFlipFromTop
 *  - UIViewAnimationOptionTransitionFlipFromBottom
 *  @param animationOption 系统内置的动画选项
 */
- (void)setAnimationOption:(UIViewAnimationOptions)animationOption;

/**
 *  此方法在delegate的viewWillAppear里面调用，用来重置BWMCoverView
 */
- (void)resetCoverView;

@end
