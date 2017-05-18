//
//  LYLPageCollectionLayout.m
//  LYLPageView
//
//  Created by wlx on 2017/5/18.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLPageCollectionLayout.h"

@implementation LYLPageCollectionLayout
-(NSMutableArray *)attributes
{
    if (!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}
-(void)prepareLayout
{
    [super prepareLayout];
    NSInteger colums = 4;
    NSInteger rows = 2;
    CGRect lastFrame = CGRectZero;
    
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    NSInteger currentSection = 0;
    CGFloat lastSectionX = 0;
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfColmeInSection:)]) {
            colums = [self.dataSource numberOfColmeInSection:section];
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInSection:)]) {
            rows = [self.dataSource numberOfRowsInSection:section];
        }
        
        CGFloat cellWidth = (CGRectGetWidth(self.collectionView.frame) - self.collectionView.contentInset.left - self.collectionView.contentInset.right - self.minimumInteritemSpacing * (colums - 1))/colums;
        CGFloat cellHeight = (CGRectGetHeight(self.collectionView.frame) - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom - self.minimumLineSpacing *(rows - 1))/rows;
        
//        NSInteger page = numberOfItems/(colums * rows) + 1;
        CGFloat lastPageX = 0;
        
        NSInteger tempIndex = 0;
        for (NSInteger item = 0; item < numberOfItems; item++ ) {
            UICollectionViewLayoutAttributes *layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:item inSection:section]];
            CGFloat x = 0;
            CGFloat y = 10;
            NSInteger pageIndex = item/(colums * rows);
            if (item%colums == 0) {
                if (item < colums && item > 0) {
                    x = self.collectionView.contentInset.left + (CGRectEqualToRect(lastFrame, CGRectZero) ? 0: CGRectGetMaxX(lastFrame)) + self.minimumInteritemSpacing;
                }else{
                    x = (pageIndex + currentSection) * CGRectGetWidth(self.collectionView.frame) + self.collectionView.contentInset.left;
                }
                
            }else{
                
                if (pageIndex == tempIndex) {
                     x = self.collectionView.contentInset.left + (CGRectEqualToRect(lastFrame, CGRectZero) ? 0: CGRectGetMaxX(lastFrame)) + self.minimumInteritemSpacing;
                }else{
                    x = (pageIndex + currentSection) * CGRectGetWidth(self.collectionView.frame) + self.collectionView.contentInset.left + self.minimumInteritemSpacing;
                }
                
               
            }
            NSInteger currentColum = 0;
            if (item > 3) {
                currentColum = pageIndex == 0 ? item/colums : (item - pageIndex*rows*colums) /colums;
            }
             y = self.collectionView.contentInset.top + currentColum *(cellWidth + self.minimumLineSpacing);
            
//            if (pageIndex == 0) {
//                if ((item/colums) == 1) {
//                    y = self.collectionView.ma
//                }
//            }else{
//                y = self.collectionView.contentInset.top + (item/colums)%rows *(cellWidth + self.minimumLineSpacing);
//            }
            
            
            
            if (currentSection < section) {
                //下一组
            }else{
//            本组
            }
            CGRect frame = frame = CGRectMake(x, y, cellWidth, cellHeight);
            layoutAttribute.frame = frame = CGRectMake(x, y, cellWidth, cellHeight);
            [self.attributes addObject:layoutAttribute];
            lastFrame = frame;
            tempIndex = pageIndex;
        }
        lastFrame = CGRectMake(CGRectGetMinX(lastFrame), CGRectGetMinY(lastFrame), tempIndex *self.collectionView.frame.size.width, CGRectGetHeight(lastFrame));
        currentSection = section;
    }
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributes;
}
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(10000, 0);
}
@end
