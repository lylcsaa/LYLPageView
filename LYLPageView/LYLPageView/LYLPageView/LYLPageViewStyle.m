//
//  LYLPageViewStyle.m
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLPageViewStyle.h"

@implementation LYLPageViewStyle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setDefaultStyle];
    }
    return self;
}
-(void)_setDefaultStyle
{
    _kTitleViewHeight = 44.0;
    _kTitleMargin = 20.0;
    _kNomalTitleColor = [UIColor blackColor];
    _kSelectedTitleColor = [UIColor redColor];
    _kTitleViewBackgroundColor = [UIColor whiteColor];
    _kTitleNomalFont = [UIFont systemFontOfSize:18];
    _kTitleSelectFont = [UIFont systemFontOfSize:20];
    _kTitleHeight = 40.0;
    _kTitleBackLayerColor = [UIColor grayColor];
    _hasBackMask = YES;
    _maskStyle = LYLTitleViewMaskStyleRoundMask;
    _kUnderLineMaskHeight = 6;
    _kUnderlineMargin = 6;
    _titleViewAnimationStyle = LYLTitleViewAnimationStyleColor;
    _kPageControlHeight = 20;
    _kEnableScroll = YES;
    _pageCollectionStyle = LYLPageCollectionStyleTitleTop;
    _minimumLineSpacing = 10;
    _minimumInteritemSpacing = 10;
    _edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionViewBackgroundColor = [UIColor whiteColor];
    _pageCantrolBackgroundColor = [UIColor clearColor];
    _pageControlSelectedColor = [UIColor grayColor];
    _pageControlUnSelectedColor = [UIColor lightGrayColor];
    _pageViewBackgroundColor = [UIColor whiteColor];
    
}
@end
