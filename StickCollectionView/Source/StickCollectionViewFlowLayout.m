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
    NSArray *oldItems = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allItems = [[NSMutableArray alloc]initWithArray:oldItems copyItems:YES];
    
    __block UICollectionViewLayoutAttributes *headerAttributes = nil;
    
    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            headerAttributes = attributes;
        }
        else {
            [self updateCellAttributes:attributes withSectionHeader:headerAttributes];
            
        }
    }];
    
    return allItems;
}

- (void)updateCellAttributes:(UICollectionViewLayoutAttributes *)attributes withSectionHeader:(UICollectionViewLayoutAttributes *)headerAttributes {
    
    CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
    CGFloat maxY = attributes.frame.origin.y - CGRectGetHeight(headerAttributes.bounds);
    CGFloat finalY = MAX(minY, maxY);
    
    CGPoint origin = attributes.frame.origin;
    
    CGFloat deltaY = (finalY - origin.y) / CGRectGetHeight(attributes.frame);
    
    if (self.firstItemTransform) {
        attributes.transform = CGAffineTransformMakeScale((1- deltaY * self.firstItemTransform), (1 - deltaY * self.firstItemTransform));
    }

    origin.y = finalY;
    attributes.frame = (CGRect){origin, attributes.frame.size};
    attributes.zIndex = attributes.indexPath.row;

}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
