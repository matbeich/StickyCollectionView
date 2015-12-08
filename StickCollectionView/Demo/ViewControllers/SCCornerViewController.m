//
//  DEMOViewController.m
//  StickCollectionView
//
//  Created by Bogdan Matveev on 21/09/15.
//  Copyright (c) 2015 Bogdan Matveev. All rights reserved.
//

#import "SCCornerViewController.h"
#import "SCCornerCollectionViewCell.h"
#import "UIColor+Hex.h"

@interface SCCornerViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *citiesArray;
@property (strong, nonatomic) NSArray *colorsArray;
@end

static NSString *const kDemoCell = @"demoCell";
static const float kCellHeight = 120.f;
static const float kItemSpace = -20.f;

@implementation SCCornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.citiesArray = @[@"Moscow", @"London", @"New York", @"Paris", @"Madrid", @"Rio", @"Tokyo", @"St.Petersburg", @"Barcelona", @"Kiev", @"Praga", @"Istambul"];
    self.colorsArray = @[@"EE5464", @"DC4352", @"FD6D50", @"EA583F", @"F6BC43", @"8DC253", @"4FC2E9", @"3CAFDB", @"5D9CEE", @"4B89DD", @"AD93EE", @"977BDD"];
}

#pragma mark -=CollectionView datasource=-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.citiesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCCornerCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kDemoCell forIndexPath:indexPath];
    NSString *hexString =self.colorsArray[indexPath.row];
    UIColor *color = [UIColor colorFromHexString:hexString];
    
    cell.color = color;
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

#pragma mark -=Actions=-
- (IBAction)actionClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
