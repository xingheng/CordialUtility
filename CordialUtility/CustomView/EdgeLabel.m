//
//  EdgeLabel.m
//
//  Created by WeiHan on 2/1/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "EdgeLabel.h"

@implementation EdgeLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    UIEdgeInsets insets = self.textInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];

    rect.origin.x -= insets.left;
    rect.origin.y -= insets.top;

    if (self.text.length > 0) {
        rect.size.width += (insets.left + insets.right);
        rect.size.height += (insets.top + insets.bottom);
    }

    return rect;
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (void)setTextInsets:(UIEdgeInsets)textInsets
{
    _textInsets = textInsets;

    [self invalidateIntrinsicContentSize];
}

@end
