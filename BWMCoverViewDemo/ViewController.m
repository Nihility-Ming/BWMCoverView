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
    
    NSArray *arr = @[@{
                        @"pic" : @"/upload/20143521633.jpg"
                     },
                     @{
                        @"pic" : @"/upload/2014315173631.jpg"
                     },
                     @{
                        @"pic" : @"/upload/2014315173643.jpg"
                     },
                     @{
                         @"pic" : @"/upload/2014315173653.jpg"
                     },
                     @{
                         @"pic" : @"/upload/201431517372.jpg"
                     }];
    NSMutableArray *realArray = [[NSMutableArray alloc] init];
    for (NSDictionary *tempDict in arr) {
        NSString *urlStr = [@"http://image.9skg.com" stringByAppendingString:[tempDict objectForKey:@"pic"]];
        [realArray addObject:urlStr];
    }
    // 以上代码只为了构建一个包含图片地址的数组而已——realArray

    
    /**
     * 快速创建BWMCoverView
     * models是一个包含图片地址的数组
     * placeholderImageNamed为图片加载前的本地占位图片名
     */
    BWMCoverView *coverView = [BWMCoverView coverViewWithModels:realArray andFrame:CGRectMake(10, 50, 300, 400) andPlaceholderImageNamed:@"defaultImage" andClickdCallBlock:^(NSInteger index) {
        NSLog(@"你选择了第%d个图片", index);
    }];
    
    // 请打开下面的东西逐个调试
    // [coverView setAutoPlayWithDelay:3.0]; // 设置自动播放
    // [coverView stopAutoPlayWithBOOL:YES]; // 停止自动播放
    // [coverView stopAutoPlayWithBOOL:NO]; // 恢复开启自动播放
    // [coverView setAnimationOption:UIViewAnimationOptionTransitionCurlUp]; // 设置切换动画
    
    [self.view addSubview:coverView];
}

@end
