//
//  PTOrderStateView.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 27/11/2015.
//  Copyright © 2015 CHEN KAIDI. All rights reserved.
//


#import "PTOrderStateView.h"
#define kLabelHorizontalInset 10

@interface PTOrderStateView()
@property (nonatomic, strong) UILabel *orderIDLabel;
@property (nonatomic, strong) UILabel *orderDateLabel;
@property (nonatomic, strong) UILabel *orderStateLabel;
@property (nonatomic, strong) UILabel *orderTotalCostLabel;
@end

@implementation PTOrderStateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.orderIDLabel];
        [self addSubview:self.orderDateLabel];
        [self addSubview:self.orderStateLabel];
        [self addSubview:self.orderTotalCostLabel];
    }
    return self;
}

-(void)setAttributeWithOrderID:(NSString *)orderID orderDate:(NSString *)orderDate orderState:(PTOrderState)orderState totalCost:(NSString *)totalCost needHighlightOrderState:(BOOL)highlightOrderState{
    self.orderIDLabel.text = [NSString stringWithFormat:@"订单号:%@",orderID];
    self.orderDateLabel.text = orderDate;
    self.orderStateLabel.text = [self getOrderStateTextFromStateCode:orderState];
    if (totalCost) {
        self.orderTotalCostLabel.hidden = NO;
        self.orderTotalCostLabel.text = [NSString stringWithFormat:@"订单金额：%@",totalCost];
        self.orderTotalCostLabel.attributedText = [self highlightText:totalCost inFullText:self.orderTotalCostLabel.text font:self.orderTotalCostLabel.font];
    }else{
        self.orderTotalCostLabel.hidden = YES;
        self.orderTotalCostLabel.text = @"";
    }
    if (highlightOrderState) {
        self.orderStateLabel.textColor = [UIColor redColor];
    }else{
        self.orderStateLabel.textColor = [UIColor blackColor];
    }
    
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize orderIDLabelSize = [self.orderIDLabel.text soSizeWithFont:self.orderIDLabel.font constrainedToWidth:self.width];
    CGSize orderDateLabelSize = [self.orderDateLabel.text soSizeWithFont:self.orderDateLabel.font constrainedToWidth:self.width];
    self.orderIDLabel.frame = CGRectMake(kLabelHorizontalInset, self.height/2-orderIDLabelSize.height, orderIDLabelSize.width, orderIDLabelSize.height);
    self.orderDateLabel.frame = CGRectMake(kLabelHorizontalInset, self.orderIDLabel.bottom+4, orderDateLabelSize.width, orderDateLabelSize.height);
    if (self.orderTotalCostLabel.hidden) {
        self.orderStateLabel.frame = CGRectMake(self.orderIDLabel.right+kLabelHorizontalInset, self.height/2-self.orderTotalCostLabel.font.lineHeight/2, self.width-self.orderIDLabel.right-kLabelHorizontalInset*2, self.orderTotalCostLabel.font.lineHeight);
    }else{
        self.orderStateLabel.frame = CGRectMake(self.orderIDLabel.right+kLabelHorizontalInset, self.height/2-self.orderTotalCostLabel.font.lineHeight, self.width-self.orderIDLabel.right-kLabelHorizontalInset*2, self.orderTotalCostLabel.font.lineHeight);
    }
    self.orderTotalCostLabel.frame = CGRectMake(self.orderDateLabel.right+kLabelHorizontalInset, self.orderStateLabel.bottom+4, self.width-self.orderDateLabel.right-kLabelHorizontalInset*2, self.orderStateLabel.font.lineHeight);
}

-(NSString *)getOrderStateTextFromStateCode:(PTOrderState)stateCode{
    NSString *stateText = @"";
    switch (stateCode) {
        case PTOrderStatePendingPayment:
            stateText = @"未付款";
            break;
        case PTOrderStateWaitingDelivery:
            stateText = @"已付款等待发货";
            break;
        case PTOrderStateApplyingAfterSaleSerivce:
            stateText = @"申请售后中";
            break;
        case PTOrderStateOrderShipped:
            stateText = @"已付款已发货";
            break;
        case PTOrderStateDelivered:
            stateText = @"已签收，交易完成";
            break;
        case PTOrderStateDeliveryRejected:
            stateText = @"退签";
            break;
        case PTOrderStateCancelled:
            stateText = @"订单已取消";
            break;
        default:
            break;
    }
    return stateText;
}

- (NSAttributedString *)highlightText:(NSString *)targetText inFullText:(NSString*) fullText font:(UIFont *)font{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:fullText];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:targetText options:0 error:&error];
    NSArray *matches = [regex matchesInString:fullText
                                      options:0
                                        range:NSMakeRange(0, fullText.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attributedString length])];
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match rangeAtIndex:0];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor redColor]
                                 range:matchRange];
    }
    
    return attributedString;
}

#pragma mark - getters/setters
-(UILabel *)orderIDLabel{
    if (!_orderIDLabel) {
        _orderIDLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderIDLabel.font = [UIFont systemFontOfSize:14];
    }
    return _orderIDLabel;
}

-(UILabel *)orderDateLabel{
    if (!_orderDateLabel) {
        _orderDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderDateLabel.font = [UIFont systemFontOfSize:12];
        _orderDateLabel.textColor = [UIColor grayColor];
    }
    return _orderDateLabel;
}

-(UILabel *)orderStateLabel{
    if (!_orderStateLabel) {
        _orderStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderStateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _orderStateLabel.textAlignment = NSTextAlignmentRight;
        _orderStateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _orderStateLabel;
}

-(UILabel *)orderTotalCostLabel{
    if (!_orderTotalCostLabel) {
        _orderTotalCostLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderTotalCostLabel.font = [UIFont systemFontOfSize:12];
        _orderTotalCostLabel.textAlignment = NSTextAlignmentRight;
        _orderTotalCostLabel.textColor = [UIColor blackColor];
    }
    return _orderTotalCostLabel;
}

@end
