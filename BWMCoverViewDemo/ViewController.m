//
//  ViewController.m
//  BWMCoverViewDemo
//
//  Created by 伟明 毕 on 14-10-19.
//  Copyright (c) 2014年 BWM. All rights reserved.
//

#import "ViewController.h"
#import "BWMCoverView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 此数组用来保存BWMCoverViewModel
    NSMutableArray *realArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<5; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"http://www.iphone567.com/wp-content/uploads/2014/10/image0%d.jpg", i+1];
        NSString *imageTitle = [NSString stringWithFormat:@"第%d个小猫", i+1];
        BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:imageTitle];
        [realArray addObject:model];
    }
    
    // 以上代码只为了构建一个包含BWMCoverViewModel的数组而已——realArray

    
    /**
     * 快速创建BWMCoverView
     * models是一个包含BWMCoverViewModel的数组
     * placeholderImageNamed为图片加载前的本地占位图片名
     */
    BWMCoverView *coverView = [BWMCoverView coverViewWithModels:realArray andFrame:self.view.frame andPlaceholderImageNamed:BWMCoverViewDefaultImage andClickdCallBlock:^(NSInteger index) {
        NSLog(@"你点击了第%d个图片", index);
    }];
    [self.view addSubview:coverView];
    
    // 只需以上两句即可创建BWMCoverView了，也可以继续往下看，自定义更多效果
    
    // 滚动视图每一次滚动都会回调此方法
    [coverView setScrollViewCallBlock:^(NSInteger index) {
        NSLog(@"当前滚动到第%d个页面", index);
    }];
    
    // 请打开下面的东西逐个调试
    [coverView setAutoPlayWithDelay:3.0]; // 设置自动播放
    coverView.imageViewsContentMode = UIViewContentModeScaleAspectFit; // 图片显示内容模式模式
    // [coverView stopAutoPlayWithBOOL:YES]; // 停止自动播放
    // [coverView stopAutoPlayWithBOOL:NO]; // 恢复自动播放
    // [coverView setAnimationOption:UIViewAnimationOptionTransitionCurlUp]; // 设置切换动画
    // coverView.titleLabel.hidden = YES; //隐藏TitleLabel
    
    //  主要有以下UI成员：
    //    coverView2.scrollView
    //    coverView2.pageControl
    //    coverView2.titleLabel
    // 详情请查看接口文件
    
#warning 修改属性后必须调用updateView方法
    [coverView updateView]; //修改属性后必须调用updateView方法，更新视图
    
    /*
    // 你也可以试着调用init方法创建BWMCoverView
    BWMCoverView *coverView2 = [[BWMCoverView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:coverView2];
    
    coverView2.models = realArray;
    coverView2.placeholderImageNamed = BWMCoverViewDefaultImage;
    coverView2.animationOption = UIViewAnimationOptionTransitionCurlUp;
    
    [coverView2 setCallBlock:^(NSInteger index) {
        NSLog(@"你点击了第%d个图片", index);
    }];
    
    [coverView2 setScrollViewCallBlock:^(NSInteger index) {
        NSLog(@"当前滚动到第%d个页面", index);
    }];
    
    
#warning 修改属性后必须调用updateView方法
    [coverView2 updateView];
    */
}

@end
