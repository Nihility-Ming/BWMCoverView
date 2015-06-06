//
//  ViewController.m
//  BWMCoverView
//
//  Created by btw on 14/12/25.
//  Copyright (c) 2014年 Nihility. All rights reserved.
//

#import "ViewController.h"
#import "BWMCoverView.h"

@interface ViewController ()

@property (strong, nonatomic) BWMCoverView *coverView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    NSMutableArray *dataArray = [NSMutableArray new];
    for (int i = 0; i<10; i++) {
        // 有图有标题
        BWMCoverViewModel *model = [BWMCoverViewModel coverViewModelWithImageURLString:@"http://picm.photophoto.cn/077/161/011/1610112059.jpg" imageTitle:@"美吃海鲜"];
        
        // 只有图
        // BWMCoverViewModel *model = [BWMCoverViewModel coverViewModelWithImageURLString:@"http://picm.photophoto.cn/077/161/011/1610112059.jpg"];
        
        [dataArray addObject:model];
    }
    
    // BWMCoverView依赖于SDWebImage，所以使用前必须有SDWebImage的库支持
    self.coverView = [BWMCoverView coverViewWithModels:nil andFrame:CGRectInset(self.view.bounds, 20, 130) andPlaceholderImageNamed:BWMCoverViewDefaultImage andImageViewsContentMode:UIViewContentModeScaleToFill andClickdCallBlock:^(int index) {
        NSLog(@"Clickd Index %d", index);
    } andScrolledCallBlock:^(int index) {
        NSLog(@"Scrolled to %d", index);
    }];
    
    // configuration cover view
     // 设置数据源
    [self.coverView setModels:dataArray];
    
    // 设置滚动时间
    [self.coverView setAutoPlayWithDelay:4.0f];
    
    // 自定义动画，默认是UIViewAnimationOptionTransitionNone
    [self.coverView setAnimationOption:UIViewAnimationOptionTransitionFlipFromRight];
    
    //  [self.coverView stopAutoPlayWithBOOL:YES or NO]; // 暂停或继续轮播
    
     // 修改参数后请调用更新视图
    [self.coverView updateView];
    
    [self.view addSubview:self.coverView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#warning 开启自动播放的时候必须重置，否则会崩溃
    [self.coverView resetCoverView];
}

@end
