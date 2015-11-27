//
//  PTOrderProductSummaryView.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import "PTOrderProductSummaryView.h"
#define kLabelHorizontalInset 10
#define kPriceLabelWidth 70
#define kLineSpacing 2
@interface PTOrderProductSummaryView ()
@property (nonatomic, strong) PTOrderProductSummaryItem *item;
@property (nonatomic, strong) UIImageView *productIconView;
@property (nonatomic, strong) UILabel *productTitleLabel;
@property (nonatomic, strong) UILabel *productSpecsLabel;
@property (nonatomic, strong) UILabel *productPriceLabel;
@property (nonatomic, strong) UILabel *productQtyLabel;
@property (nonatomic, strong) UILabel *refundStateLabel;
@end

@implementation PTOrderProductSummaryView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.04];
        [self addSubview:self.productIconView];
        [self addSubview:self.productTitleLabel];
        [self addSubview:self.productSpecsLabel];
        [self addSubview:self.productPriceLabel];
        [self addSubview:self.productQtyLabel];
        [self addSubview:self.refundStateLabel];
    }
    return self;
}

-(void)setAttributeWithItem:(PTOrderProductSummaryItem *)item placeholderImage:(UIImage *)placeholderImage{
    self.item = item;
    [self.productIconView sd_setImageWithURL:[NSURL URLWithString:item.productIconURL] placeholderImage:placeholderImage];
    self.productTitleLabel.text = item.productTitle;
    self.productSpecsLabel.text = [NSString stringWithFormat:@"颜色：%@ 尺码：%@",item.productColor,item.productSize];
    self.productPriceLabel.text = item.productPrice;
    self.productQtyLabel.text = item.productQty;
    self.refundStateLabel.text = item.productRefundState;
    self.productTitleLabel.attributedText = [self adjustLineSpacingForText:self.productTitleLabel.text font:self.productTitleLabel.font];
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize specLabelSize = [self.productSpecsLabel.text soSizeWithFont:self.productSpecsLabel.font constrainedToWidth:self.width-self.height-kLabelHorizontalInset*3];
    self.productIconView.frame = CGRectMake(kLabelHorizontalInset, kLabelHorizontalInset, self.height-kLabelHorizontalInset*2, self.height-kLabelHorizontalInset*2);
    self.productPriceLabel.frame = CGRectMake(self.width-kLabelHorizontalInset-kPriceLabelWidth, kLabelHorizontalInset, kPriceLabelWidth, self.productPriceLabel.font.lineHeight);
    self.productQtyLabel.frame = CGRectMake(self.width-kLabelHorizontalInset-kPriceLabelWidth, self.productPriceLabel.bottom+5, kPriceLabelWidth, self.productQtyLabel.font.lineHeight);
    self.productTitleLabel.frame = CGRectMake(self.productIconView.right+kLabelHorizontalInset, kLabelHorizontalInset, self.productQtyLabel.left-self.productIconView.right-kLabelHorizontalInset*2, self.productTitleLabel.font.lineHeight*2+kLineSpacing);
    self.productSpecsLabel.frame = CGRectMake(self.productTitleLabel.left, self.productIconView.bottom-specLabelSize.height, self.productTitleLabel.width, specLabelSize.height);
    self.refundStateLabel.frame = CGRectMake(self.width-kLabelHorizontalInset-kPriceLabelWidth, self.productSpecsLabel.top, kPriceLabelWidth, self.refundStateLabel.font.lineHeight);
}

-(NSAttributedString *)adjustLineSpacingForText:(NSString *)text font:(UIFont *)font{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:kLineSpacing];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [text length])];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, text.length)];
    return attrString;
}

-(UIImageView *)productIconView{
    if (!_productIconView) {
        _productIconView = [[UIImageView alloc] init];
    }
    return _productIconView;
}

-(UILabel *)productTitleLabel{
    if (!_productTitleLabel) {
        _productTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _productTitleLabel.font = [UIFont systemFontOfSize:14];
        _productTitleLabel.numberOfLines = 2;
        _productTitleLabel.textAlignment = NSTextAlignmentJustified;
    }
    return _productTitleLabel;
}

-(UILabel *)productSpecsLabel{
    if (!_productSpecsLabel) {
        _productSpecsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _productSpecsLabel.textColor = [UIColor grayColor];
        _productSpecsLabel.font = [UIFont systemFontOfSize:12];
    }
    return _productSpecsLabel;
}

-(UILabel *)productPriceLabel{
    if (!_productPriceLabel) {
        _productPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _productPriceLabel.font = [UIFont systemFontOfSize:14];
        _productPriceLabel.textAlignment = NSTextAlignmentRight;
        _productPriceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _productPriceLabel;
}

-(UILabel *)productQtyLabel{
    if (!_productQtyLabel) {
        _productQtyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _productQtyLabel.textAlignment = NSTextAlignmentRight;
        _productQtyLabel.font = [UIFont systemFontOfSize:12];
    }
    return _productQtyLabel;
}

-(UILabel *)refundStateLabel{
    if (!_refundStateLabel) {
        _refundStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _refundStateLabel.textAlignment = NSTextAlignmentRight;
        _refundStateLabel.font = [UIFont systemFontOfSize:12];
        _refundStateLabel.textColor = [UIColor redColor];
        _refundStateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _refundStateLabel;
}


@end
