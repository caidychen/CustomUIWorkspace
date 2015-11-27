//
//  PTOrderProductSummaryItem.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import "PTOrderProductSummaryItem.h"

@implementation PTOrderProductSummaryItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    PTOrderProductSummaryItem *item = [super itemWithDict:dict];
    if(!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return (item);
    }
    item.productID = [dict safeStringForKey:kProductID];
    item.productRefundState = [dict safeStringForKey:kProductRefundState];
    item.productTitle = [dict safeStringForKey:kProductTitle];
    item.productColor = [dict safeStringForKey:kProductColor];
    item.productSize = [dict safeStringForKey:kProductSize];
    item.productPrice = [dict safeStringForKey:kProductPrice];
    item.productQty = [dict safeStringForKey:kProductQty];
    item.productIconURL = [dict safeStringForKey:kProductIconURL];
    return (item);
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _productID = nil;
        _productRefundState = nil;
        _productTitle = nil;
        _productColor = nil;
        _productSize = nil;
        _productPrice = nil;
        _productQty = nil;
        _productIconURL = nil;
    }
    return (self);
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    PTOrderProductSummaryItem *item = [super copyWithZone:zone];
    item.productID = self.productID;
    item.productRefundState = self.productRefundState;
    item.productTitle = self.productTitle;
    item.productColor = self.productColor;
    item.productSize = self.productSize;
    item.productPrice = self.productPrice;
    item.productQty = self.productQty;
    item.productIconURL = self.productIconURL;
    return (item);
}

@end
