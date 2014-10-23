//
//  BWMCoverViewModel.h
//  BWMCoverViewDemo
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 BWM. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 BWMCoverViewModel类，包含两个属性：
 图片地址字符串(imageURLString)和图片标题(imageTitle)
 */
@interface BWMCoverViewModel : NSObject

/** 图片地址字符串 */
@property (nonatomic, copy) NSString *imageURLString;
/** 图片标题 */
@property (nonatomic, copy) NSString *imageTitle;

- (id)initWithImageURLString:(NSString *)imageURLString imageTitle:(NSString *)imageTitle;

+ (id)coverViewModelWithImageURLString:(NSString *)imageURLString imageTitle:(NSString *)imageTitle;

@end