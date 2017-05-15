//
//  LYLPageViewController.h
//  LYLPageView
//
//  Created by wlx on 17/5/15.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYLPageViewController : UIViewController
-(void)lyl_addChildViewController:(UIViewController*)controller title:(NSString*)title;
-(void)lyl_loadView;
@end
