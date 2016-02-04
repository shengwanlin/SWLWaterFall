//
//  WLWaterFallLayout.h
//  waterfall
//
//  Created by ASHENG on 16/1/5.
//  Copyright © 2016年 sunvlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWLWaterFallLayout;

@protocol SWLWaterFallLayoutDelegate <NSObject>

@required
/// number of columns   设置列数
- (NSUInteger)numberOfColumnCountWithlayout:(SWLWaterFallLayout *)layout;
/// line spacing        设置间距
- (CGFloat)lineSpacingWithlayout:(SWLWaterFallLayout *)layout;
/// height of item at indexPath   每个item的高度
- (CGFloat)SWLWaterFallLayout:(SWLWaterFallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SWLWaterFallLayout : UICollectionViewLayout

@property (nonatomic, assign) id<SWLWaterFallLayoutDelegate> delegate;

@end

