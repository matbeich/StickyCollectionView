//
//  DEMOViewController.m
//  StickCollectionView
//
//  Created by Bogdan Matveev on 21/09/15.
//  Copyright (c) 2015 Bogdan Matveev. All rights reserved.
//

#import "DEMOViewController.h"
#import "DemoCollectionViewCell.h"

@interface DEMOViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *citiesArray;
@end

static NSString *const kDemoCell = @"demoCell";
static const float kCellHeight = 100.f;
static const float kItemSpace = -10.f;

@implementation DEMOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.citiesArray = @[@"Moscow", @"London", @"New York", @"Paris", @"Madrid", @"Rio", @"Tokyo", @"St.Petersburg", @"Barcelona", @"Kiev", @"Praga", @"Istambul"];
}

#pragma mark -=CollectionView datasource=-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.citiesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kDemoCell forIndexPath:indexPath];
    cell.city = self.citiesArray[indexPath.row];
    return cell;
}

#pragma mark -=CollectionView layout=-
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), kCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kItemSpace;
}

@end
