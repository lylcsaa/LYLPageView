//
//  LYLPageViewStyle.h
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+RondomColor.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LYLTitleViewMaskStyle)
{
    LYLTitleViewMaskStyleNone,
    LYLTitleViewMaskStyleUnderLine,
    LYLTitleViewMaskStyleRoundMask
};
typedef NS_ENUM(NSInteger, LYLTitleViewAnimationStyle)
{
    LYLTitleViewAnimationStyleNormal,
    LYLTitleViewAnimationStyleColor
};

typedef NS_ENUM(NSInteger, LYLPageCollectionStyle)
{
    LYLPageCollectionStyleNormal,
    LYLPageCollectionStyleTitleTop,
    LYLPageCollectionStyleTitleBottom
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
 **:<#注释#>
 **/
@property (nonatomic,assign)CGFloat kPageControlHeight;
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
/**
 **:<#注释#>
 **/
@property (nonatomic,assign)LYLTitleViewAnimationStyle titleViewAnimationStyle;

/**
 **:title是否可以滚动
 **/
@property (nonatomic,assign)BOOL kEnableScroll;

/**
 **:标题在顶部还是地部
 **/
@property (nonatomic,assign)LYLPageCollectionStyle pageCollectionStyle;


/**
 **:collectionView间距
 **/
@property (nonatomic,assign)CGFloat minimumLineSpacing;
@property (nonatomic,assign)CGFloat minimumInteritemSpacing;

/**
 **:collectionView内边距
 **/
@property (nonatomic,assign)UIEdgeInsets edgeInsets;

/**
 **:collectionView 背景颜色
 **/
@property (nonatomic,strong)UIColor * collectionViewBackgroundColor;

/**
 **:pageControl 背景颜色
 **/
@property (nonatomic,strong)UIColor * pageCantrolBackgroundColor;
/**
 **:pageControl 选中颜色
 **/
@property (nonatomic,strong)UIColor * pageControlSelectedColor;
/**
 **:pageControl 未选中的颜色
 **/
@property (nonatomic,strong)UIColor * pageControlUnSelectedColor;
/**
 **:pageView 北京颜色
 **/
@property (nonatomic,strong)UIColor * pageViewBackgroundColor;

@end
