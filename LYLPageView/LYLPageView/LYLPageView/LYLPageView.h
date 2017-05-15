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
@interface LYLPageView : UIView
-(instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray*)titles
        childViewControllers:(NSArray*)childViewControllers
        fatherViewController:(UIViewController*)fatherViewController
                       style:(LYLPageViewStyle*)style;
@end
