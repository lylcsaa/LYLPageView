//
//  LYLPageViewStyle.h
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LYLTitleViewMaskStyle)
{
    LYLTitleViewMaskStyleNone,
    LYLTitleViewMaskStyleUnderLine,
    LYLTitleViewMaskStyleRoundMask
};

@interface LYLPageViewStyle : NSObject
/**
 **:titleView 的高度，默认 44.0
 **/
@property (nonatomic,assign) CGFloat kTitleViewHeight;
/**
 **:title高度
 **/
@property (nonatomic,assign)CGFloat kTitleHeight;
/**
 **:每个title的间隙 默认 10.0
 **/
@property (nonatomic,assign)CGFloat kTitleMargin;
/**
 **:title颜色
 **/
@property (nonatomic,strong)UIColor *kNomalTitleColor;
/**
 **:title选中颜色
 **/
@property (nonatomic,strong)UIColor *kSelectedTitleColor;

/**
 **:title滑块背景颜色
 **/
@property (nonatomic,strong)UIColor *kTitleBackLayerColor;

/**
 **:titleview 背景色
 **/
@property (nonatomic,strong)UIColor *kTitleViewBackgroundColor;

/**
 **:title字体
 **/
@property (nonatomic,strong)UIFont *kTitleNomalFont;
/**
 **:title选中字体
 **/
@property (nonatomic,strong)UIFont *kTitleSelectFont;

/**
 **:titleView是否有backLayer
 **/
@property (nonatomic,assign)BOOL hasBackMask;

/**
 **:title选中指示器的样式
 **/
@property (nonatomic,assign)LYLTitleViewMaskStyle maskStyle;

/**
 **:<#注释#>
 **/
@property (nonatomic,assign)CGFloat kUnderLineMaskHeight;
/**
 **:<#注释#>
 **/
@property (nonatomic,assign)CGFloat kUnderlineMargin;
@end
