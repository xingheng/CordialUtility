//
//  FlowLayoutCollectionView.m
//
//  Created by WeiHan on 1/4/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "FlowLayoutCollectionView.h"

#define EqualConstraint(__attribute__, __view1__, __view2__)      [NSLayoutConstraint constraintWithItem: __view1__ attribute: __attribute__ relatedBy: NSLayoutRelationEqual toItem: __view2__ attribute: __attribute__ multiplier: 1.0 constant: 0].active = YES

NSString *const FlowLayoutCollectionCellIDKey = @"FlowLayoutCollectionCellID";
NSString *const FlowLayoutCollectionSectionHeaderIDKey = @"FlowLayoutCollectionSectionHeaderID";
NSString *const FlowLayoutCollectionSectionFooterIDKey = @"FlowLayoutCollectionSectionFooterID";

#pragma mark - FlowLayoutCollectionView

@implementation FlowLayoutCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];

    if (self = [super initWithFrame:frame collectionViewLayout:layout ? : flowLayout]) {
        self.dataSource = self;
        self.delegate = self;

        self.backgroundColor = UIColor.whiteColor;
        [self registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:FlowLayoutCollectionCellIDKey];
    }

    return self;
}

#pragma mark - Property

- (UICollectionViewFlowLayout *)flowLayout
{
    return (UICollectionViewFlowLayout *)self.collectionViewLayout;
}

- (void)setCellClass:(Class)cellClass
{
    _cellClass = cellClass;
    [self registerClass:cellClass forCellWithReuseIdentifier:FlowLayoutCollectionCellIDKey];
}

- (void)setDataItems:(NSArray *)dataItems
{
    if (![_dataItems isEqual:dataItems]) {
        _dataItems = dataItems;
        [self reloadData];
    }
}

- (void)setCellSize:(CGSize)cellSize
{
    _cellSize = cellSize;
    self.flowLayout.itemSize = _cellSize;
}

- (void)setSectionHeaderSize:(CGSize)sectionHeaderSize
{
    _sectionHeaderSize = sectionHeaderSize;
    self.flowLayout.headerReferenceSize = sectionHeaderSize;

    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FlowLayoutCollectionSectionHeaderIDKey];
}

- (void)setSectionFooterSize:(CGSize)sectionFooterSize
{
    _sectionFooterSize = sectionFooterSize;
    self.flowLayout.footerReferenceSize = sectionFooterSize;

    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FlowLayoutCollectionSectionFooterIDKey];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;

    if (self.cellForItemAtIndexPath) {
        cell = self.cellForItemAtIndexPath(indexPath);
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:FlowLayoutCollectionCellIDKey forIndexPath:indexPath];
    }

    if (self.configCellBlock) {
        self.configCellBlock(cell, indexPath);
    }

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FlowLayoutCollectionSectionHeaderIDKey forIndexPath:indexPath];
        UIView *targetView = nil;

        if (self.configHeaderView) {
            targetView = self.configHeaderView(headerView, indexPath);
        }

        // Clean up all the reusable subviews from it.
        [headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        if (targetView) {
            [headerView addSubview:targetView];

            targetView.translatesAutoresizingMaskIntoConstraints = NO;
            EqualConstraint(NSLayoutAttributeTop, targetView, headerView);
            EqualConstraint(NSLayoutAttributeLeft, targetView, headerView);
            EqualConstraint(NSLayoutAttributeBottom, targetView, headerView);
            EqualConstraint(NSLayoutAttributeRight, targetView, headerView);
        }

        reusableView = headerView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FlowLayoutCollectionSectionFooterIDKey forIndexPath:indexPath];
        UIView *targetView = nil;

        if (self.configFooterView) {
            targetView = self.configFooterView(footerView, indexPath);
        }

        // Clean up all the reusable subviews from it.
        [footerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        if (targetView) {
            [footerView addSubview:targetView];

            targetView.translatesAutoresizingMaskIntoConstraints = NO;
            EqualConstraint(NSLayoutAttributeTop, targetView, footerView);
            EqualConstraint(NSLayoutAttributeLeft, targetView, footerView);
            EqualConstraint(NSLayoutAttributeBottom, targetView, footerView);
            EqualConstraint(NSLayoutAttributeRight, targetView, footerView);
        }

        reusableView = footerView;
    }

    return reusableView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectCellBlock) {
        self.selectCellBlock(indexPath);
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.longPressCellBlock) {
        return self.longPressCellBlock(indexPath);
    }

    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    return NO;
}

- (nullable UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point API_AVAILABLE(ios(13.0))
{
    return nil;
}

#pragma mark - Extended Delegate (Invocation)

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self.extendedDelegate respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self.extendedDelegate];
    } else {
       [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([self.extendedDelegate respondsToSelector:aSelector]) {
        return [(id)self.extendedDelegate methodSignatureForSelector:aSelector];
    }

    return [super methodSignatureForSelector:aSelector];
}

@end
