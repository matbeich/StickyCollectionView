//
//  StickCollectionViewFlowLayout.m
//  StickCollectionView
//
//  Created by Bogdan Matveev on 21/09/15.
//  Copyright (c) 2015 Bogdan Matveev. All rights reserved.
//

#import "StickCollectionViewFlowLayout.h"

@implementation StickCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *allItems = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    NSMutableDictionary *firstCells = [NSMutableDictionary dictionary];
    
    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        NSIndexPath *indexPath = attributes.indexPath;
        
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            headers[@(indexPath.section)] = attributes;
        }
        else {
            UICollectionViewLayoutAttributes *firstItemAttributes = firstCells[@(indexPath.row)];
            if (!firstItemAttributes || indexPath.row > firstItemAttributes.indexPath.row) {
                firstCells[@(indexPath.row)] = attributes;
                [self updateFirstCellAttributes:attributes withSectionHeader:headers[@(indexPath.section)]];
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
    origin.y = finalPosition;
    attributes.frame = (CGRect){origin, attributes.frame.size};
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
