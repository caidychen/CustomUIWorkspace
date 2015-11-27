//
//  PTMyOrderSummaryItem.h
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import "SOBaseItem.h"

typedef NS_ENUM(NSInteger, PTOrderState) {
    PTOrderStateNone = 0,
    PTOrderStatePendingPayment = 1,           // 未付款
    PTOrderStateWaitingDelivery = 2,          // 已付款等待发货
    PTOrderStateApplyingAfterSaleSerivce = 3, // 申请售后中
    PTOrderStateOrderShipped = 4,             // 已付款已发货
    PTOrderStateDelivered = 5,                // 已签收，交易完成
    PTOrderStateDeliveryRejected = 6,         // 退签
    PTOrderStateCancelled = 7                 // 订单已取消
};

typedef NS_ENUM(NSInteger, PTOrderAction){
    PTOrderActionNone = 0,                    // 无操作
    PTOrderActionPayOrCancel = 1,             // 立即支付／取消订单
    PTOrderActionRequestRefund = 2,           // 申请退款
    PTOrderActionCheckShippingStatus = 3,     // 查看物流
    PTOrderActionApplyAfterSaleService = 4    // 申请售后
};

#define kOrderID @"kOrderID"
#define kOrderDate @"kOrderDate"
#define kOrderState @"kOrderState"
#define kItemList @"kItemList"
#define kTotalItemCount @"kTotalItemCount"
#define kTotalItemCost @"kTotalItemCost"
#define kShippingFee @"kShippingFee"
#define kOrderAction @"kOrderAction"

@interface PTMyOrderSummaryItem : SOBaseItem <NSCopying>
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *orderDate;
@property (nonatomic, assign) PTOrderState orderState;
@property (nonatomic, strong) NSArray *itemlist;
@property (nonatomic, strong) NSString *totalItemCount;
@property (nonatomic, strong) NSString *totalItemCost;
@property (nonatomic, strong) NSString *shippingFee;
@property (nonatomic, assign) PTOrderAction orderAction;
@end
