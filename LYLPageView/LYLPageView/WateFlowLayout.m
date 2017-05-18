//
//  WateFlowLayout.m
//  LYLPageView
//
//  Created by wlx on 2017/5/17.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "WateFlowLayout.h"

@implementation WateFlowLayout
-(NSMutableArray *)attributes
{
    if (!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOfItems = 2.0;
    }
    return self;
}
//准备布局
-(void)prepareLayout
{
    [super prepareLayout];
    
//    1.获取cell的个数
    
    NSInteger sections = self.collectionView.numberOfSections;
    for (int i = 0; i < sections; i ++ ) {
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    NSInteger numberOfitems = [self.collectionView numberOfItemsInSection:i];
    CGFloat items = self.numberOfItems;
    NSMutableArray *heights = [NSMutableArray arrayWithArray:@[@(self.collectionView.contentInset.top),@(self.collectionView.contentInset.top)]];
    CGFloat cellW = (self.collectionView.bounds.size.width - (self.collectionView.contentInset.left + self.minimumInteritemSpacing*(items + 1) + self.collectionView.contentInset.right))/items;
        for (int j = 0; j < numberOfitems; j ++) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
            CGFloat minH = [heights[0] floatValue];
            int index = 0;
            if (j > 0) {
                for (int k = 0; k < heights.count; k++) {
                    int height = [heights[k] intValue];
                    if (height < minH) {
                        minH = height;
                        index = k;
                    }
                }
            }
            
            CGFloat x = self.collectionView.contentInset.left + self.minimumInteritemSpacing*(index + 1) + index*cellW;
            CGFloat cellHeight = arc4random_uniform(100) + 100;
            if ((j+2)%2 ==  0) {
                cellHeight = 300;
            }else{
                cellHeight = 150;
            }
            
            
            CGFloat y = minH + self.minimumLineSpacing;
            CGRect frame = CGRectZero;
            frame = CGRectMake(x, y, cellW, cellHeight);
            attribute.frame = frame;
            NSLog(@">>>>>:%@",NSStringFromCGRect(frame));
            CGFloat h = [heights[index] intValue];
            h = frame.origin.y + frame.size.height;
            [heights replaceObjectAtIndex:index withObject:@(h)];
            [self.attributes addObject:attribute];
            
        }
    self.heights = heights;
    }
}
// 告诉系统怎么布局
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributes;
}

//告诉系统滚动大小
-(CGSize)collectionViewContentSize
{
    int max = 0;
    for (NSNumber *number in self.heights) {
        CGFloat hight = [number floatValue];
        if (hight > max) {
            max = hight;
        }
    }
    return CGSizeMake(0, max);
}
@end
