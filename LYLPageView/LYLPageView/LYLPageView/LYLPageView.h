//
//  LYLPageView.h
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLContainerView.h"
#import "LYLTitleView.h"
#import "LYLPageViewStyle.h"
#import "LYLPageCollectionLayout.h"
@interface LYLPageView : UIView<LYLPageCollectionViewDataSource>
-(instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray*)titles
        childViewControllers:(NSArray*)childViewControllers
        fatherViewController:(UIViewController*)fatherViewController
                       style:(LYLPageViewStyle*)style;


-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles style:(LYLPageViewStyle *)style;
@end
