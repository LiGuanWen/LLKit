//
//  BrowerFlowLayout.m
//  ImageBrowerTest
//
//  Created by JPlay on 14-6-13.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "BrowerFlowLayout.h"

#define IMAGE_CELL_PADDING 10



@interface BrowerFlowLayout ()

@property (nonatomic, strong)NSMutableArray *pageAttributes;


@end

@implementation BrowerFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = IMAGE_CELL_PADDING;
        
    }
    return self;
}


- (void)prepareLayout {
    [super prepareLayout];
    
    self.collectionView.pagingEnabled = YES;
    
    self.pageAttributes = [NSMutableArray array];
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (int section = 0; section < sections; section++) {
        NSInteger rowsInSection = [self.collectionView numberOfItemsInSection:section];
        for (int row = 0; row < rowsInSection; row++) {
            [self.pageAttributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]]];
        }
    }
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *pageAttribute in self.pageAttributes) {
        if (CGRectContainsPoint(rect, pageAttribute.frame.origin)) {
            [attributes addObject:pageAttribute];
        }else if (CGRectContainsPoint(rect, CGPointMake(CGRectGetMaxX(pageAttribute.frame), CGRectGetMinY(pageAttribute.frame)))) {
            [attributes addObject:pageAttribute];
        }
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect pageBounds = self.collectionView.bounds;
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = CGSizeMake(CGRectGetWidth(pageBounds) - IMAGE_CELL_PADDING,
                                 CGRectGetHeight(pageBounds));
    attributes.alpha = 1.0;
    attributes.center = CGPointMake(CGRectGetWidth(pageBounds)*indexPath.row + CGRectGetWidth(pageBounds)/2.0,
                                    CGRectGetMidY(self.collectionView.bounds));
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}



- (CGSize)collectionViewContentSize {
    CGRect pageBounds = self.collectionView.bounds;
    NSInteger sections = [self.collectionView numberOfSections];
    NSInteger itemCount = 0;
    
    for (int i = 0; i < sections; i++) {
        itemCount += [self.collectionView numberOfItemsInSection:i];
    }
    
    return CGSizeMake(CGRectGetWidth(pageBounds)*itemCount,
                      CGRectGetHeight(pageBounds));
}



@end
