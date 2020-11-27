//
//  BaseTableView.m
//
//  Created by WeiHan on 07/07/2017.
//  Copyright © 2017 WeiHan. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
    }

    return self;
}

#pragma mark - Public

- (void)setDataItems:(NSArray<BaseDataItem *> *)dataItems
{
    _dataItems = dataItems;

    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"Should be overwritten in subclasses!");
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    !self.selectionBlock ? : self.selectionBlock(indexPath);
}

#pragma mark - UIScrollViewDelegate (Invocation)

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self.scrollDelegate respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self.scrollDelegate];
    } else {
       [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([self.scrollDelegate respondsToSelector:aSelector]) {
        return [(id)self.scrollDelegate methodSignatureForSelector:aSelector];
    }

    return [super methodSignatureForSelector:aSelector];
}

@end
