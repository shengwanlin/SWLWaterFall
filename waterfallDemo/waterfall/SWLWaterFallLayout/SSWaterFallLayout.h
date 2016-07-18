//
//  WLWaterFallLayout.h
//  waterfall
//
//  Created by ASHENG on 16/1/5.
//  Copyright © 2016年 sunvlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSWaterFallLayout;

@protocol SSWaterFallLayoutDelegate <NSObject>

@required
/// number of columns   设置列数
- (NSUInteger)numberOfColumnCountWithlayout:(SSWaterFallLayout *)layout;
/// line spacing        设置间距
- (CGFloat)lineSpacingWithlayout:(SSWaterFallLayout *)layout;
/// height of item at indexPath   每个item的高度
- (CGFloat)SSWaterFallLayout:(SSWaterFallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SSWaterFallLayout : UICollectionViewLayout

@property (nonatomic, assign) id<SSWaterFallLayoutDelegate> delegate;

@end

