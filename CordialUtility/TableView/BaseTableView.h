//
//  BaseTableView.h
//
//  Created by WeiHan on 07/07/2017.
//  Copyright © 2017 WeiHan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDataItem.h"

@interface BaseTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray<__kindof BaseDataItem *> *dataItems;

@property (nonatomic, copy) void (^ selectionBlock)(NSIndexPath *indexPath);

@property (nonatomic, weak) id<UIScrollViewDelegate> scrollDelegate;

@end
