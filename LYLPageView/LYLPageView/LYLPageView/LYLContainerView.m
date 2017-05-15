//
//  LYLContainerView.m
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLContainerView.h"

@interface LYLContainerView ()
@property(nonatomic,strong)UICollectionView *collectionView;

/**
 **:<#注释#>
 **/
@property (nonatomic,strong)NSArray *childViewControllers;
/**
 **:
 **/
@property (nonatomic,strong)LYLPageViewStyle *style;

/**
 **:<#注释#>
 **/
@property (nonatomic,weak) UIViewController *fatherViewController;

/**
 **:开始位置
 **/
@property (nonatomic,assign)CGFloat startX;
@end
@implementation LYLContainerView

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs fatherVc:(UIViewController *)fatherVc style:(LYLPageViewStyle*)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.childViewControllers = childVcs;
        self.style = style;
        self.fatherViewController = fatherVc;
        self.startX = 0;
        [self _setUpUI];
    }
    return self;
}
-(void)_setUpUI
{
    [self addSubview:self.collectionView];
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.scrollsToTop = NO;
    }
    return _collectionView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIViewController *childVC = self.childViewControllers[indexPath.row];
    [self.fatherViewController addChildViewController:childVC];
    [cell.contentView addSubview:childVC.view];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int currentIndex = scrollView.contentOffset.x/self.collectionView.bounds.size.width;
    int tagartIndex = 0;
    if (scrollView.contentOffset.x == self.startX) {
        return;
    }
    if (scrollView.contentOffset.x - self.startX > 0) {
        //向右
        tagartIndex = currentIndex + 1;
    }else{
        currentIndex += 1;
        tagartIndex = currentIndex - 1;
    }
    
    if (tagartIndex < 0) {
        tagartIndex = 0;
    }
    if (tagartIndex >= self.childViewControllers.count) {
        tagartIndex = (int)self.childViewControllers.count - 1;
    }
    
    CGFloat progress = ABS((scrollView.contentOffset.x - currentIndex * self.collectionView.bounds.size.width))/self.collectionView.bounds.size.width;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(containerView:tagartIndex:fromIndex:progress:)]) {
        [self.delegate containerView:self tagartIndex:tagartIndex fromIndex:currentIndex progress:progress];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startX = scrollView.contentOffset.x;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int tagartIndex = scrollView.contentOffset.x/self.collectionView.bounds.size.width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(containerView: selectedIndex:)]) {
        [self.delegate containerView:self selectedIndex:tagartIndex];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        int tagartIndex = scrollView.contentOffset.x/self.collectionView.bounds.size.width;
        if (self.delegate && [self.delegate respondsToSelector:@selector(containerView: selectedIndex:)]) {
            [self.delegate containerView:self selectedIndex:tagartIndex];
        }
    }
}


#pragma mark --LYLTitleViewDelegate----
-(void)titleView:(LYLTitleView *)titleView didSelectedItemIndex:(int)selectedIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

}
@end
