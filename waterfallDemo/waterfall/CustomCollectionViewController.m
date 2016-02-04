//
//  CustomCollectionViewController.m
//  waterfall
//
//  Created by ASHENG on 16/1/5.
//  Copyright © 2016年 sunvlink. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "SWLWaterFallLayout.h"

@interface CustomCollectionViewController () <SWLWaterFallLayoutDelegate>

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;

@end

@implementation CustomCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    ((SWLWaterFallLayout *)self.collectionView.collectionViewLayout).delegate = self;
    
    // Do any additional setup after loading the view.
    
    [self initData];
//    [self initCellsHeights];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    _cellHeightArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"00%d.jpg", i]];
        [mutableArray addObject:image];
        [_cellHeightArray addObject:@(image.size.height/2)];
    }
    
    [mutableArray addObjectsFromArray:mutableArray];
    [mutableArray addObjectsFromArray:mutableArray];
    [mutableArray addObjectsFromArray:mutableArray];
    self.images = mutableArray;
    
    
    [self.cellHeightArray addObjectsFromArray:_cellHeightArray];
    [self.cellHeightArray addObjectsFromArray:_cellHeightArray];
    [self.cellHeightArray addObjectsFromArray:_cellHeightArray];
    
}

/// 随机生成cell的高度
- (void)initCellsHeights
{
    _cellHeightArray = [[NSMutableArray alloc] initWithCapacity:_images.count];
    for (int i = 0; i < _images.count; i ++) {
        
        CGFloat height = arc4random() % (int)(200.0 - 120.0) + 120.0;
        
        [_cellHeightArray addObject:@(height)];
        
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.images[indexPath.row]];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.backgroundView = imageView;
    
    return cell;
}

#pragma mark - WLWaterFallLayoutDelegate

- (NSUInteger)numberOfColumnCountWithlayout:(SWLWaterFallLayout *)layout
{
    return 2;
}

- (CGFloat)lineSpacingWithlayout:(SWLWaterFallLayout *)layout
{
    return 2.f;
}

- (CGFloat)SWLWaterFallLayout:(SWLWaterFallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeightArray[indexPath.row] floatValue];
}

@end
