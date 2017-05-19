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
@class LYLPageView;
@protocol LYLPageViewDelegate <NSObject>


@optional
-(LYLPageColumAndRow)lyl_pageView:(LYLPageView*)pageView columAndRowsInPerSection:(NSInteger)section;
-(void)lyl_pageView:(LYLPageView*)pageView didSelectWithIndexPath:(NSIndexPath*)indexPath;
@required
-(UICollectionViewCell*)lyl_pageView:(LYLPageView*)pageView collectionView:(UICollectionView*)collectionView cellForRowInIndexPath:(NSIndexPath*)indexPath reuserIdentifer:(NSString*)reuserIdentifer;
-(NSInteger)lyl_pageView:(LYLPageView*)pageView numberOfRowsInSection:(NSInteger)section;

@end



@interface LYLPageView : UIView<LYLPageCollectionViewDataSource>

/**
 **:<#注释#>
 **/
@property (nonatomic,weak)id <LYLPageViewDelegate> delegate;

/**
 **:<#注释#>
 **/
@property (nonatomic,assign)NSInteger numberOfColums;
/**
 **:<#注释#>
 **/
@property (nonatomic,assign)NSInteger numberOfRows;

-(instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray*)titles
        childViewControllers:(NSArray*)childViewControllers
        fatherViewController:(UIViewController*)fatherViewController
                       style:(LYLPageViewStyle*)style;


-(instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray*)titles
                       style:(LYLPageViewStyle *)style;
@end
