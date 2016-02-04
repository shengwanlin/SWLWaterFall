//
//  WLWaterFallLayout.m
//  waterfall
//
//  Created by ASHENG on 16/1/5.
//  Copyright © 2016年 sunvlink. All rights reserved.
//

#import "SWLWaterFallLayout.h"

@implementation SWLWaterFallLayout 
{
    // section的数量
    NSUInteger _numberOfSections;
    // section中cell的数量
    NSUInteger _numberOfItemsInSection;
    // 瀑布流的列数
    NSUInteger _columnCount;
    // cell边距
    CGFloat _padding;
    // cell的宽度
    CGFloat _cellWidth;
    // 每列cell的x坐标
    NSMutableArray *_cellXArray;
    // 每列cell的offset Y
    NSMutableArray *_cellYArray;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    [self initData];
    
    [self initCellWidth];
}
/// collectionView's contentSize
- (CGSize)collectionViewContentSize
{
    CGFloat height = [self maxCellYAtArray:_cellYArray];
    
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 初始化每列cell的y坐标
    _cellYArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i ++) {
        [_cellYArray addObject:@(0)];
    }
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < _numberOfItemsInSection; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [mutableArray addObject:attributes];
    }
    
    return mutableArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 设置每个cell的frame位置
    CGRect frame = CGRectZero;
    
    CGFloat cellHeight = _delegate?[_delegate SWLWaterFallLayout:self heightForItemAtIndexPath:indexPath]:0;
    
    NSUInteger minYIndex = [self minYIndexAtArray:_cellYArray];
    
    CGFloat cellX = [_cellXArray[minYIndex] floatValue];
    
    CGFloat cellY = [_cellYArray[minYIndex] floatValue];
    
    frame = CGRectMake(cellX, cellY, _cellWidth, cellHeight);
    layoutAttributes.frame = frame;
    
    // 更新数组中的offset Y
    _cellYArray[minYIndex] = @(cellY + cellHeight + _padding);
    
    return layoutAttributes;
}

#pragma mark - Initialize

/// 初始化数据
- (void)initData
{
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfItemsInSection = [self.collectionView numberOfItemsInSection:0];
    
    // 自定义列数、间距、高度等
    if (_delegate) {
        _columnCount = [_delegate numberOfColumnCountWithlayout:self];
        _padding = [_delegate lineSpacingWithlayout:self];
    }
    // 默认值 default values
    else {
        _columnCount = 2;
        _padding = 2.f;
    }
}
/// 初始化cell的frame
- (void)initCellWidth
{
    // 计算cell的宽
    _cellWidth = ([[UIScreen mainScreen] bounds].size.width - (_columnCount - 1) * _padding) / _columnCount;
    
    // 计算每列cell的x坐标
    _cellXArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    
    for (int i = 0; i < _columnCount; i ++) {
        
        CGFloat x = i * (_cellWidth + _padding);
        
        [_cellXArray addObject:@(x)];
    }
}

#pragma mark -

/// 计算数组中的最大值
- (CGFloat)maxCellYAtArray:(NSArray *)array
{
    if (!array.count) {
        return 0.f;
    }
    
    CGFloat maxY = [array[0] floatValue];
    
    for (NSNumber *value in array) {
        
        CGFloat y = [value floatValue];
        
        if (maxY < y) {
            maxY = y;
        }
        
    }
    return maxY;
}
/// 计算数组中的最小元素的'索引' index
- (NSUInteger)minYIndexAtArray:(NSArray *)array
{
    if (!array.count) {
        return 0.f;
    }
    
    NSUInteger index = 0;
    
    CGFloat minY = [array[0] floatValue];
    
    for (NSNumber *value in array) {
        
        CGFloat y = [value floatValue];
        
        if (minY > y) {
            minY = y;
            index = [array indexOfObject:value];
        }
        
    }
    return index;
}

@end
