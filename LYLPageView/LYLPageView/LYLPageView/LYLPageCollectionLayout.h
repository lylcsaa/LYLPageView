//
//  LYLPageCollectionLayout.h
//  LYLPageView
//
//  Created by wlx on 2017/5/18.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYLPageCollectionLayout;
@protocol LYLPageCollectionViewDataSource<NSObject>
-(NSInteger)numberOfColmeInSection:(NSInteger)section;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
@end
@interface LYLPageCollectionLayout : UICollectionViewFlowLayout
/**
 **:所有的布局属性数组
 **/
@property (nonatomic,strong)NSMutableArray * attributes;
/**
 **:<#注释#>
 **/
@property (nonatomic,weak)id<LYLPageCollectionViewDataSource> dataSource;
@end
