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
/// number of columns
- (NSUInteger)numberOfColumnCountWithlayout:(SSWaterFallLayout *)layout;
/// line spacing
- (CGFloat)lineSpacingWithlayout:(SSWaterFallLayout *)layout;
/// height of item at indexPath  
- (CGFloat)SSWaterFallLayout:(SSWaterFallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SSWaterFallLayout : UICollectionViewLayout

@property (nonatomic, assign) id<SSWaterFallLayoutDelegate> delegate;

@end

