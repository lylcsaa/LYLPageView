//
//  LYLTitleLabel.h
//  LYLPageView
//
//  Created by wlx on 2017/5/18.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYLTitleLabel : UILabel
/**
 **:<#注释#>
 **/
@property (nonatomic,assign)CGFloat progress;
/**
 **:<#注释#>
 **/
@property (nonatomic,assign)BOOL startLeft;

/**
 **:<#注释#>
 **/
@property (nonatomic,strong)UIColor * color;

@property (nonatomic,strong) UIColor *yl_textColor;
@end
