//
//  LYLTitleView.h
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLPageViewStyle.h"
#import "LYLContainerView.h"
@class LYLTitleView;
@protocol LYLTitleViewDelegate <NSObject>

-(void)titleView:(LYLTitleView*)titleView didSelectedItemIndex:(int)selectedIndex;

@end


@protocol LYLContainerViewDelegate;
@interface LYLTitleView : UIView<LYLContainerViewDelegate>

/**
 **:<#注释#>
 **/
@property (nonatomic,weak)id<LYLTitleViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(LYLPageViewStyle*)style;
@end
