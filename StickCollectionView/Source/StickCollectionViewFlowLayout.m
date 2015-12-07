//
//  StickCollectionViewFlowLayout.m
//  StickCollectionView
//
//  Created by Bogdan Matveev on 21/09/15.
//  Copyright (c) 2015 Bogdan Matveev. All rights reserved.
//

#import "StickCollectionViewFlowLayout.h"

static const CGFloat kAttributesTransform = .025f;

@implementation StickCollectionViewFlowLayout

- (void)prepareLayout {
    _transformEnabled = NO;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *oldItems = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allItems = [[NSMutableArray alloc]initWithArray:oldItems copyItems:YES];
    
    __block UICollectionViewLayoutAttributes *headerAttributes = nil;
    __block UICollectionViewLayoutAttributes *firstItemAttributes = nil;
    
    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        NSIndexPath *indexPath = attributes.indexPath;
        
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            headerAttributes = attributes;
        }
        else {
            if (!firstItemAttributes || indexPath.row > firstItemAttributes.indexPath.row) {
                firstItemAttributes = attributes;
                [self updateFirstCellAttributes:firstItemAttributes withSectionHeader:headerAttributes];
            }
        }
    }];
    
    return allItems;
}

- (void)updateFirstCellAttributes:(UICollectionViewLayoutAttributes *)attributes withSectionHeader:(UICollectionViewLayoutAttributes *)headerAttributes {
    
    CGFloat maxY = CGRectGetMaxY(attributes.frame) - CGRectGetHeight(headerAttributes.bounds);
    CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
    CGFloat largerYPosition = MAX(minY, attributes.frame.origin.y);
    CGFloat finalPosition = MIN(largerYPosition, maxY);
    
    CGPoint origin = attributes.frame.origin;
    
    CGFloat deltaY = (finalPosition - origin.y) / CGRectGetHeight(attributes.frame);
    origin.y = finalPosition;
    
    if (self.isTransformEnabled) {
        attributes.transform = CGAffineTransformMakeScale((1- deltaY * kAttributesTransform), (1 - deltaY * kAttributesTransform));
    }
    
    attributes.frame = (CGRect){origin, attributes.frame.size};
    attributes.zIndex = attributes.indexPath.row;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
