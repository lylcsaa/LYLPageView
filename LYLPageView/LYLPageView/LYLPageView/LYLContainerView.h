//
//  LYLContainerView.h
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLPageViewStyle.h"
#import "LYLTitleView.h"
@class LYLContainerView;
@protocol LYLContainerViewDelegate <NSObject>

-(void)containerView:(LYLContainerView*)containerView selectedIndex:(int)selectedIndex;
-(void)containerView:(LYLContainerView*)containerView tagartIndex:(int)tagartIndex fromIndex:(int)fromIndex progress:(CGFloat)progress;

@end

@protocol LYLTitleViewDelegate;
@interface LYLContainerView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,LYLTitleViewDelegate>

/**
 **:<#注释#>
 **/
@property (nonatomic,weak)id<LYLContainerViewDelegate>delegate;


- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs fatherVc:(UIViewController *)fatherVc style:(LYLPageViewStyle*)style;
@end
