//
//  BWMCoverViewModel.m
//  BWMCoverViewDemo
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 BWM. All rights reserved.
//

#import "BWMCoverViewModel.h"

@implementation BWMCoverViewModel

- (id)initWithImageURLString:(NSString *)imageURLString imageTitle:(NSString *)imageTitle
{
    if(self = [super init])
    {
        self.imageURLString = imageURLString;
        self.imageTitle = imageTitle;
    }
    return self;
}

+ (id)coverViewModelWithImageURLString:(NSString *)imageURLString imageTitle:(NSString *)imageTitle
{
    BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageURLString imageTitle:imageTitle];
    return model;
}

@end
