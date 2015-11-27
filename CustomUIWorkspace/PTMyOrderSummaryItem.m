//
//  PTMyOrderSummaryItem.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import "PTMyOrderSummaryItem.h"
#import "PTOrderProductSummaryItem.h"

@implementation PTMyOrderSummaryItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    PTMyOrderSummaryItem *item = [super itemWithDict:dict];
    if(!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return (item);
    }
    item.orderID = [dict safeObjectForKey:kOrderID];
    item.orderDate = [dict safeObjectForKey:kOrderDate];
    item.orderState = [[dict safeObjectForKey:kOrderDate] integerValue];
    NSArray *itemList = [dict safeObjectForKey:kItemList];
    NSMutableArray *productOrderList = [[NSMutableArray alloc] init];
    for(NSDictionary *tempDict in itemList){
        PTOrderProductSummaryItem *item = [PTOrderProductSummaryItem itemWithDict:tempDict];
        [productOrderList addObject:item];
    }
    item.itemlist = productOrderList;
    item.totalItemCount =  [dict safeObjectForKey:kTotalItemCount];
    item.totalItemCost = [dict safeObjectForKey:kTotalItemCost];
    item.shippingFee = [dict safeObjectForKey:kShippingFee];
    item.orderAction = [[dict safeObjectForKey:kOrderAction] integerValue];
    return (item);
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _orderID = nil;
        _orderDate = nil;
        _itemlist = nil;
        _totalItemCount = nil;
        _totalItemCost = nil;
        _shippingFee = nil;
    }
    return (self);
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    PTMyOrderSummaryItem *item = [super copyWithZone:zone];
    item.orderID = self.orderID;
    item.orderDate = self.orderDate;
    item.orderState = self.orderState;
    item.itemlist = self.itemlist;
    item.totalItemCount = self.totalItemCount;
    item.totalItemCost = self.totalItemCost;
    item.shippingFee = self.shippingFee;
    item.orderAction = self.orderAction;
    return (item);
}

@end
