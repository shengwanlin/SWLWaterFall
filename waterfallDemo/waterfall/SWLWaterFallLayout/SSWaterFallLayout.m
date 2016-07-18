//
//  WLWaterFallLayout.m
//  waterfall
//
//  Created by ASHENG on 16/1/5.
//  Copyright © 2016年 sunvlink. All rights reserved.
//

#import "SSWaterFallLayout.h"

@implementation SSWaterFallLayout 
{
    NSUInteger _numberOfSections;

    NSUInteger _numberOfItemsInSection;

    NSUInteger _columnCount;

    CGFloat _padding;

    CGFloat _cellWidth;
    
    NSMutableArray *_cellXArray;

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
    
    CGRect frame = CGRectZero;
    
    CGFloat cellHeight = _delegate?[_delegate SSWaterFallLayout:self heightForItemAtIndexPath:indexPath]:0;
    
    NSUInteger minYIndex = [self minYIndexAtArray:_cellYArray];
    
    CGFloat cellX = [_cellXArray[minYIndex] floatValue];
    
    CGFloat cellY = [_cellYArray[minYIndex] floatValue];
    
    frame = CGRectMake(cellX, cellY, _cellWidth, cellHeight);
    layoutAttributes.frame = frame;
    
    _cellYArray[minYIndex] = @(cellY + cellHeight + _padding);
    
    return layoutAttributes;
}

#pragma mark - Initialize

- (void)initData
{
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfItemsInSection = [self.collectionView numberOfItemsInSection:0];
    
    if (_delegate) {
        _columnCount = [_delegate numberOfColumnCountWithlayout:self];
        _padding = [_delegate lineSpacingWithlayout:self];
    }
    
    else {
        _columnCount = 2;
        _padding = 2.f;
    }
}

- (void)initCellWidth
{

    _cellWidth = ([[UIScreen mainScreen] bounds].size.width - (_columnCount - 1) * _padding) / _columnCount;
    

    _cellXArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    
    for (int i = 0; i < _columnCount; i ++) {
        
        CGFloat x = i * (_cellWidth + _padding);
        
        [_cellXArray addObject:@(x)];
    }
}

#pragma mark -

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
