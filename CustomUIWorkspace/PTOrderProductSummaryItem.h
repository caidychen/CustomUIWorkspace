//
//  PTOrderProductSummaryItem.h
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import "SOBaseItem.h"
#define kProductID @"kProductID"
#define kProductRefundState @"kProductRefundState"
#define kProductTitle @"kProductTitle"
#define kProductColor @"kProductColor"
#define kProductSize  @"kProductSize"
#define kProductPrice @"kProductPrice"
#define kProductQty   @"kProductQty"
#define kProductIconURL @"kProductIconURL"

@interface PTOrderProductSummaryItem : SOBaseItem<NSCopying>
@property (nonatomic, strong) NSString *productID;
@property (nonatomic, strong) NSString *productRefundState;
@property (nonatomic, strong) NSString *productTitle;
@property (nonatomic, strong) NSString *productColor;
@property (nonatomic, strong) NSString *productSize;
@property (nonatomic, strong) NSString *productPrice;
@property (nonatomic, strong) NSString *productQty;
@property (nonatomic, strong) NSString *productIconURL;

+ (instancetype)itemWithDict:(NSDictionary *)dict ;
@end
