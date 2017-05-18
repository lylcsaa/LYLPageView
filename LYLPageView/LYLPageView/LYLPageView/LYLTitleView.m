//
//  LYLTitleView.m
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLTitleView.h"
#import "LYLTitleLabel.h"
@interface LYLTitleView()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *titles;
/**
 **:style
 **/
@property (nonatomic,strong)LYLPageViewStyle *style;

/**
 **:<#注释#>
 **/
@property (nonatomic,strong)UIScrollView *scrollView;

/**
 **:<#注释#>
 **/
@property (nonatomic,strong)NSMutableArray *titleLabels;
/**
 **:前一个选中的tag
 **/
@property (nonatomic,assign)int tagartTag;

/**
 **:<#注释#>
 **/

/**
 **:<#注释#>
 **/
@property (nonatomic,assign)BOOL isTouchTitle;
@property (nonatomic,strong)CAShapeLayer *backLayer;
@end
@implementation LYLTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(LYLPageViewStyle*)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.style = style;
        [self setUpUI];
        _isTouchTitle = NO;
    }
    return self;
}
-(void)setUpUI
{
    self.backgroundColor = self.style.kTitleViewBackgroundColor;
    [self addSubview:self.scrollView];
    NSMutableArray *arrM = [NSMutableArray array];
    LYLTitleLabel *lastLabel = nil;
    for (int i = 0; i < self.titles.count; i ++) {
        NSString *title = self.titles[i];
        LYLTitleLabel *label = [[LYLTitleLabel alloc] initWithFrame:
                          CGRectMake(lastLabel ? (lastLabel.frame.size.width + lastLabel.frame.origin.x + self.style.kTitleMargin) : self.style.kTitleMargin*0.5,
                                     0,
                                     [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.style.kTitleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.style.kTitleNomalFont} context:nil].size.width,
                                     self.style.kTitleHeight)];
        
        [self.scrollView addSubview:label];
        label.tag = i;
        label.text = title;
        label.font = self.style.kTitleNomalFont;
        if (i == 0) {
            label.textColor = self.style.kSelectedTitleColor;
            label.transform = CGAffineTransformMakeScale(1.2, 1.2);
            [self _addBackMask:label];
            self.tagartTag = i;
        }else{
            label.textColor = self.style.kNomalTitleColor;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitle:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        
        
        [arrM addObject:label];
        lastLabel = label;
    }
    self.titleLabels = arrM;
    if (self.style.kEnableScroll) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame) + self.style.kTitleMargin*0.5, 0);
    }else{
        CGFloat lastLabelMaxX = CGRectGetMaxX(lastLabel.frame);
        CGFloat space = self.bounds.size.width - lastLabelMaxX - self.style.kTitleMargin;
        if (space < 0) {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame) + self.style.kTitleMargin*0.5, 0);
        }else{
            self.scrollView.contentSize = CGSizeMake(0, 0);
            CGFloat addMargin = space/self.titleLabels.count;
            [self _resetFrames:addMargin];
        }
        
    }
    
    
}
-(void)_resetFrames:(CGFloat)addMargin
{
    CGFloat lastX = 0;
    for (LYLTitleLabel *label  in self.titleLabels) {
        label.frame = CGRectMake(lastX ? lastX: self.style.kTitleMargin * 0.5, CGRectGetMinY(label.frame), CGRectGetWidth(label.frame) + addMargin, CGRectGetHeight(label.frame));
        label.textAlignment = NSTextAlignmentCenter;
        if (!lastX) {
            [self _addBackMask:label];
        }
        lastX = CGRectGetMaxX(label.frame) + self.style.kTitleMargin;
    }

}
-(void)_addBackMask:(UILabel*)label
{
    if (self.style.hasBackMask) {
        
        switch (self.style.maskStyle) {
            case LYLTitleViewMaskStyleRoundMask:
            {
                self.backLayer.frame = CGRectMake(CGRectGetMinX(label.frame) - self.style.kUnderlineMargin, self.style.kUnderlineMargin , label.frame.size.width  + self.style.kUnderlineMargin*2, CGRectGetHeight(label.bounds) - self.style.kUnderlineMargin*2);
                self.backLayer.cornerRadius = (CGRectGetHeight(label.bounds) - self.style.kUnderlineMargin*2)*0.5;
                 [self.scrollView.layer insertSublayer:self.backLayer atIndex:0];
            }
                break;
            case LYLTitleViewMaskStyleUnderLine:
            {
                self.backLayer.frame = CGRectMake(CGRectGetMinX(label.frame) - self.style.kUnderlineMargin, CGRectGetHeight(label.bounds) - self.style.kUnderLineMaskHeight , label.frame.size.width  + self.style.kUnderlineMargin*2, self.style.kUnderLineMaskHeight);
                 [self.scrollView.layer insertSublayer:self.backLayer atIndex:0];
            }
                break;
            default:
                break;
        }
        
        
        
       
    }
    
}
-(CAShapeLayer *)backLayer
{
    if (!_backLayer) {
        _backLayer = [CAShapeLayer layer];
        _backLayer.backgroundColor = self.style.kTitleBackLayerColor.CGColor;
        _backLayer.shadowColor = [UIColor grayColor].CGColor;
        _backLayer.opacity = 0.5;
        _backLayer.shadowOpacity = 0.5;
        _backLayer.shadowOffset = CGSizeMake(2, 2);
        
    }
    return _backLayer;
}
-(void)tapTitle:(UITapGestureRecognizer*)gr
{
    _isTouchTitle = YES;
    LYLTitleLabel *tagartLabel = (LYLTitleLabel*)gr.view;
    int tagartTag = (int)tagartLabel.tag;
    if (tagartTag == self.tagartTag) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleView:didSelectedItemIndex:)]) {
        [self.delegate titleView:self didSelectedItemIndex:tagartTag];
    }
   [self _selectedTitleWithTagartIndex:tagartTag];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}
-(void)_selectedTitleWithTagartIndex:(int)tagartIndex
{
    LYLTitleLabel *tagartLabel = self.titleLabels[tagartIndex];
    [self _addBackMask:tagartLabel];
    if (tagartIndex == self.tagartTag) {
        return;
    }
    LYLTitleLabel *currentLabel = self.titleLabels[self.tagartTag];
    currentLabel.yl_textColor = self.style.kNomalTitleColor;
    tagartLabel.yl_textColor = self.style.kSelectedTitleColor;
    currentLabel.transform = CGAffineTransformMakeScale(1, 1);
    tagartLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
    CGFloat offsetX = tagartLabel.center.x - self.scrollView.bounds.size.width*0.5;
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.bounds.size.width;
    if (offsetX < 0) {
        offsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    if (self.style.kEnableScroll) {
         [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    self.tagartTag = tagartIndex;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

#pragma mark -- LYLContainerViewDelegate---

-(void)containerView:(LYLContainerView *)containerView
       selectedIndex:(int)selectedIndex
{
    if (_isTouchTitle) {
        _isTouchTitle = NO;
        return;
    }
    if (selectedIndex < 0) {
        selectedIndex = 0;
    }
    if (selectedIndex >= self.titleLabels.count) {
        selectedIndex = (int)self.titleLabels.count -1;
    }
    [self _selectedTitleWithTagartIndex:selectedIndex];
}
-(void)containerView:(LYLContainerView *)containerView
         tagartIndex:(int)tagartIndex
           fromIndex:(int)fromIndex
            progress:(CGFloat)progress
{
    if (_isTouchTitle) {
        _isTouchTitle = NO;
        return;
    }
    UIColor *tColor = [UIColor colorWithRed:progress green:0 blue:0 alpha:1.0];
    UIColor *fColor = [UIColor colorWithRed:1 - progress green:0 blue:0 alpha:1.0];
    LYLTitleLabel *tagartLabel = self.titleLabels[tagartIndex];
    LYLTitleLabel *currentLabel = self.titleLabels[fromIndex];
    
    [self _moveMaskViewAnimationWithTagartLabel:tagartLabel currentLabel:currentLabel progress:progress];
    currentLabel.transform = CGAffineTransformMakeScale(1 + 0.2 *(1-progress), 1 + 0.2 *(1-progress));
    tagartLabel.transform = CGAffineTransformMakeScale(1 + 0.2 *progress, 1 + 0.2 *progress);
    if (self.style.titleViewAnimationStyle == LYLTitleViewAnimationStyleNormal) {
        if (tagartIndex > fromIndex) {
            tagartLabel.startLeft = YES;
            currentLabel.startLeft = YES;
        }else{
            tagartLabel.startLeft = NO;
            currentLabel.startLeft = NO;
        }
        tagartLabel.color = self.style.kSelectedTitleColor;
        tagartLabel.progress = progress;
        currentLabel.color = self.style.kNomalTitleColor;
        currentLabel.progress = progress;

    }else{
        tagartLabel.textColor = tColor;
        currentLabel.textColor = fColor;
    }
    
}
-(void)_moveMaskViewAnimationWithTagartLabel:(UILabel*)tagartLabel currentLabel:(UILabel*)currentLabel progress:(CGFloat)progress
{
    
    CGFloat maxChange = tagartLabel.center.x - currentLabel.center.x;
    switch (self.style.maskStyle) {
        case LYLTitleViewMaskStyleRoundMask:
        {
            self.backLayer.frame = CGRectMake( progress * maxChange + CGRectGetMinX(currentLabel.frame), self.style.kUnderlineMargin , currentLabel.frame.size.width  + self.style.kUnderlineMargin*2 + progress*(CGRectGetWidth(tagartLabel.frame) - CGRectGetWidth(currentLabel.frame)), CGRectGetHeight(currentLabel.bounds) - self.style.kUnderlineMargin*2);
        }
            break;
        case LYLTitleViewMaskStyleUnderLine:
        {
            self.backLayer.frame = CGRectMake( progress * maxChange + CGRectGetMinX(currentLabel.frame), CGRectGetHeight(currentLabel.bounds) - self.style.kUnderLineMaskHeight , currentLabel.frame.size.width  + self.style.kUnderlineMargin*2 + progress*(CGRectGetWidth(tagartLabel.frame) - CGRectGetWidth(currentLabel.frame)), self.style.kUnderLineMaskHeight);
            
        }
            break;
        default:
            break;
    }
}
@end
