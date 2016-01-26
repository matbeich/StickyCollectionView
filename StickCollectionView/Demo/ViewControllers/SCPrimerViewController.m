//
//  SCPrimerViewController.m
//  StickyCollectionView
//
//  Created by Bogdan Matveev on 13/01/16.
//  Copyright © 2016 Bogdan Matveev. All rights reserved.
//

#import "SCPrimerViewController.h"
#import "SCPrimerCollectionViewCell.h"
#import "StickCollectionViewFlowLayout.h"

static NSString *const kDemoCell = @"primerCell";
static const CGFloat kCellSizeCoef = .8f;
static const CGFloat kFirstItemTransform = 0.05f;

@interface SCPrimerViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *lessonsArray;
@end

@implementation SCPrimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lessonsArray = @[@"Create a Hight Quality, High Ranking Search Ad",
                          @"Evolve Your Ad Campaigns with Programmatic Buying",
                          @"How Remarketing Keeps Customers Coming Back",
                          @"Surviving and Thriving on Social Media",
                          @"Keep Mobile Users Engaged In and Out of Your App",
                          @"Appeal to Searchers and Search Engines with Seo",
                          @"Build Your Business Fast with Growth Hacking",
                          @"Track Your Acquisitions with Digital Metricks"];
    
    StickCollectionViewFlowLayout *stickLayout = (StickCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    stickLayout.firstItemTransform = kFirstItemTransform;
}

#pragma mark -=CollectionView datasource=-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lessonsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCPrimerCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kDemoCell forIndexPath:indexPath];
    NSString *lesson = self.lessonsArray[indexPath.row];
    cell.lesson = lesson;
    return cell;
}

#pragma mark -=CollectionView layout=-
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.collectionView.bounds) * kCellSizeCoef);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark -=Actions=-
- (IBAction)actionClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
