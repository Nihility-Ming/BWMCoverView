//
//  BWMCoverViewModel.h
//  BWMCoverViewDemo
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 BWM. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  BWMCoverViewModel类，包含两个属性：
 *  图片地址字符串(imageURLString)和图片标题(imageTitle)
 */
@interface BWMCoverViewModel : NSObject

/**
 *  图片地址字符串
 */
@property (nonatomic, copy) NSString *imageURLString;

/**
 *  图片标题
 */
@property (nonatomic, copy) NSString *imageTitle;

/**
 *  常规的创建BWMCoverViewModel的方法
 *
 *  @param imageURLString 图片的路径字符串，可以是网络和本地路径
 *  @param imageTitle     图片的标题
 *  @warning    不推荐使用该方法
 *  @see        + coverViewModelWithImageURLString:imageTitle:
 *
 *  @return 返回BWMCoverViewModel的对象指针
 */
- (id)initWithImageURLString:(NSString *)imageURLString imageTitle:(NSString *)imageTitle;

/**
 *  快速创建BWMCoverViewModel的工厂方法
 *
 *  @param imageURLString 图片的路径字符串，可以是网络和本地路径
 *  @param imageTitle     图片的标题
 *
 *  @return 返回BWMCoverViewModel的对象指针
 */
+ (id)coverViewModelWithImageURLString:(NSString *)imageURLString imageTitle:(NSString *)imageTitle;

/**
 *  快速创建BWMCoverViewModel的工厂方法
 *
 *  @param imageURLString 图片的路径字符串，可以是网络和本地路径
 *
 *  @return 返回BWMCoverViewModel的对象指针
 */
+ (id)coverViewModelWithImageURLString:(NSString *)imageURLString;

@end