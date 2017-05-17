//
//  WateFlowLayout.h
//  LYLPageView
//
//  Created by wlx on 2017/5/17.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WateFlowLayout : UICollectionViewFlowLayout
/**
 **:<#注释#>
 **/
@property (nonatomic,strong)NSMutableArray * attributes;
@property (nonatomic,strong)NSMutableArray * heights;

/**
 **:<#注释#>
 **/
@property (nonatomic,assign)CGFloat numberOfItems;
@end
