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
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    CGFloat lastPageX = 0;
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageColumAndRowInSection:)]) {
           LYLPageColumAndRow columAndRows = [self.dataSource pageColumAndRowInSection:section];
            colums = columAndRows.colums;
            rows = columAndRows.rows;
        }
        CGFloat cellWidth = (CGRectGetWidth(self.collectionView.frame) - self.collectionView.contentInset.left - self.collectionView.contentInset.right - self.minimumInteritemSpacing * (colums - 1))/colums;
        CGFloat cellHeight = (CGRectGetHeight(self.collectionView.frame) - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom - self.minimumLineSpacing *(rows - 1))/rows;
        
        NSInteger countPerPage = colums * rows;
        
        for (NSInteger item = 0; item < numberOfItems; item++ ) {
            UICollectionViewLayoutAttributes *layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:item inSection:section]];
            CGFloat x = 0;
            CGFloat y = 0;
            NSInteger pageIndex = item/countPerPage;
            x = self.collectionView.contentInset.left + pageIndex * self.collectionView.bounds.size.width + (self.minimumInteritemSpacing + cellWidth) * (item%colums) + lastPageX;
            NSInteger row = (item%countPerPage)/colums;
            y = (cellHeight + self.minimumLineSpacing) * row;

            CGRect frame = CGRectMake(x, y, cellWidth, cellHeight);
            layoutAttribute.frame = frame;
            [self.attributes addObject:layoutAttribute];
            
        }
        lastPageX += (numberOfItems/countPerPage + 1) * self.collectionView.bounds.size.width;
        self.contentSizeX = lastPageX;
    }
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributes;
}
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentSizeX, 0);
}
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    NSInteger currentPage = proposedContentOffset.x/self.collectionView.bounds.size.width;
    NSLog(@">>>----%@----%zd", NSStringFromCGPoint(proposedContentOffset), currentPage);
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    NSInteger page = 0;
    NSInteger nextSection = 0;
    NSInteger pageInSection = 0;
    NSInteger pagesPerSection = 0;
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageColumAndRowInSection:)]) {
            LYLPageColumAndRow columAndRows = [self.dataSource pageColumAndRowInSection:section];
            if (numberOfItems%(columAndRows.colums * columAndRows.rows) == 0) {
                pagesPerSection = numberOfItems/(columAndRows.colums * columAndRows.rows);
            }else{
                pagesPerSection = numberOfItems/(columAndRows.colums * columAndRows.rows) + 1;
            }
            
            if (currentPage < page + pagesPerSection) {
                nextSection = section;
                break;
            }
            page += pagesPerSection;
        }
    }
    pageInSection = (currentPage - page);
    NSLog(@">>>>>> %zd >>>>>%zd >>>>>%zd", pageInSection, nextSection, pagesPerSection);
    
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageLayout:pageInSection:page:currentPage:)]) {
        [self.dataSource pageLayout:self pageInSection:nextSection page:pagesPerSection currentPage:pageInSection];
    }
    return proposedContentOffset;
}
@end
