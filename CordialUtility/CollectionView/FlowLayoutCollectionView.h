//
//  FlowLayoutCollectionView.h
//
//  Created by WeiHan on 1/4/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const FlowLayoutCollectionCellIDKey;
FOUNDATION_EXPORT NSString *const FlowLayoutCollectionSectionHeaderIDKey;
FOUNDATION_EXPORT NSString *const FlowLayoutCollectionSectionFooterIDKey;

@interface FlowLayoutCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readonly) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) Class cellClass;

@property (nonatomic, assign) CGSize cellSize;

@property (nonatomic, strong) NSArray<__kindof NSObject *> *dataItems;

@property (nonatomic, copy, nullable) __kindof UICollectionViewCell * (^ cellForItemAtIndexPath)(NSIndexPath *indexPath);
@property (nonatomic, copy) void (^ configCellBlock)(__kindof UICollectionViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^ selectCellBlock)(NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL (^ longPressCellBlock)(NSIndexPath *indexPath);

/// Section header and footer
@property (nonatomic, assign) CGSize sectionHeaderSize;
@property (nonatomic, copy) UIView * (^ configHeaderView)(UICollectionReusableView *reusableView, NSIndexPath *indexPath);
@property (nonatomic, assign) CGSize sectionFooterSize;
@property (nonatomic, copy) UIView * (^ configFooterView)(UICollectionReusableView *reusableView, NSIndexPath *indexPath);

/// Forward the internal not implemented delegate methods to outside caller.
@property (nonatomic, weak) id<UICollectionViewDataSource, UICollectionViewDelegate> extendedDelegate;

@end

NS_ASSUME_NONNULL_END
