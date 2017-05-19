//
//  LYLPageCollectionLayout.h
//  LYLPageView
//
//  Created by wlx on 2017/5/18.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef struct LYLPageColumAndRow {
    NSInteger colums, rows;
} LYLPageColumAndRow;
UIKIT_STATIC_INLINE LYLPageColumAndRow LYLPageColumAndRowsMake(NSInteger colums, NSInteger rows) {
    LYLPageColumAndRow columAndRows = {colums, rows};
    return columAndRows;
}
@class LYLPageCollectionLayout;
@protocol LYLPageCollectionViewDataSource<NSObject>
-(LYLPageColumAndRow)pageColumAndRowInSection:(NSInteger)section;
-(void)pageLayout:(LYLPageCollectionLayout*)layout pageInSection:(NSInteger)section page:(NSInteger)page currentPage:(NSInteger)currentPage;
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
/**
 **:<#注释#>
 **/
@property (nonatomic,assign)CGFloat contentSizeX;
@end
