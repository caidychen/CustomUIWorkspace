//
//  PTOrderStateView.h
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 27/11/2015.
//  Copyright © 2015 CHEN KAIDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTMyOrderSummaryItem.h"

@interface PTOrderStateView : UIControl

//如果totalCost为nil，则不显示订单金额总价
-(void)setAttributeWithOrderID:(NSString *)orderID orderDate:(NSString *)orderDate orderState:(PTOrderState)orderState totalCost:(NSString *)totalCost needHighlightOrderState:(BOOL)highlightOrderState;
@end
