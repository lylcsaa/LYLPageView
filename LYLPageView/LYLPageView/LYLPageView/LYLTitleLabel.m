//
//  LYLTitleLabel.m
//  LYLPageView
//
//  Created by wlx on 2017/5/18.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLTitleLabel.h"

@implementation LYLTitleLabel
{
    BOOL _shouldReDraw;
}
-(void)setProgress:(CGFloat)progress
{
    _shouldReDraw = YES;
    _progress = progress;
    [self setNeedsDisplay];
}
-(void)setYl_textColor:(UIColor *)yl_textColor
{
    _yl_textColor = yl_textColor;
    self.textColor = yl_textColor;
    _shouldReDraw = NO;
}
/* Available in Mac OS X 10.5 & later. R, S, and D are, respectively,
 premultiplied result, source, and destination colors with alpha; Ra,
 Sa, and Da are the alpha components of these colors.
 
 The Porter-Duff "source over" mode is called `kCGBlendModeNormal':
 R = S + D*(1 - Sa)
 
 Note that the Porter-Duff "XOR" mode is only titularly related to the
 classical bitmap XOR operation (which is unsupported by
 CoreGraphics). */

//kCGBlendModeClear,                  /* R = 0 */
//kCGBlendModeCopy,                   /* R = S */
//kCGBlendModeSourceIn,               /* R = S*Da */
//kCGBlendModeSourceOut,              /* R = S*(1 - Da) */
//kCGBlendModeSourceAtop,             /* R = S*Da + D*(1 - Sa) */
//kCGBlendModeDestinationOver,        /* R = S*(1 - Da) + D */
//kCGBlendModeDestinationIn,          /* R = D*Sa */
//kCGBlendModeDestinationOut,         /* R = D*(1 - Sa) */
//kCGBlendModeDestinationAtop,        /* R = S*(1 - Da) + D*Sa */
//kCGBlendModeXOR,                    /* R = S*(1 - Da) + D*(1 - Sa) */
//kCGBlendModePlusDarker,             /* R = MAX(0, (1 - D) + (1 - S)) */
//kCGBlendModePlusLighter             /* R = MIN(1, S + D) */



-(void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];
    if (!_shouldReDraw) {
        return;
    }
    CGRect fillRect = CGRectZero;
    if (self.startLeft) {
        fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    }else{
        fillRect = CGRectMake(self.bounds.size.width * (1 - self.progress), 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    }
    [self.color set];
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);//改变文字填充色
//    UIRectFrameUsingBlendMode(fillRect, kCGBlendModeCopy);//边框
    
    //    UIRectClip(fillRect);
}
@end
