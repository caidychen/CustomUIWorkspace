//
//  PTOrderProductSummaryView.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import "PTOrderProductSummaryView.h"
#define kLabelHorizontalInset 12
#define kPriceLabelWidth 60

@interface PTOrderProductSummaryView ()
@property (nonatomic, strong) PTOrderProductSummaryItem *item;
@property (nonatomic, strong) UIImageView *productIconView;
@property (nonatomic, strong) UILabel *productTitleLabel;
@property (nonatomic, strong) UILabel *productSpecsLabel;
@property (nonatomic, strong) UILabel *productPriceLabel;
@property (nonatomic, strong) UILabel *productQtyLabel;
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
    
    [self setNeedsDisplay];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize specLabelSize = [self.productSpecsLabel.text soSizeWithFont:self.productSpecsLabel.font constrainedToWidth:self.width-self.height-kLabelHorizontalInset*3];
    self.productIconView.frame = CGRectMake(kLabelHorizontalInset, kLabelHorizontalInset, self.height-kLabelHorizontalInset*2, self.height-kLabelHorizontalInset*2);
    self.productPriceLabel.frame = CGRectMake(self.width-kLabelHorizontalInset-kPriceLabelWidth, kLabelHorizontalInset, kPriceLabelWidth, self.productPriceLabel.font.leading);
    self.productQtyLabel.frame = CGRectMake(self.width-kLabelHorizontalInset-kPriceLabelWidth, self.productPriceLabel.bottom+kLabelHorizontalInset/2, kPriceLabelWidth, self.productQtyLabel.font.leading);
    self.productTitleLabel.frame = CGRectMake(self.productIconView.right+kLabelHorizontalInset, kLabelHorizontalInset, self.productQtyLabel.left-self.productIconView.right-kLabelHorizontalInset*2, self.productTitleLabel.font.leading*2);
    self.productSpecsLabel.frame = CGRectMake(self.productTitleLabel.left, self.productIconView.bottom-specLabelSize.height, specLabelSize.width, specLabelSize.height);
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
        _productTitleLabel.numberOfLines = 2;
        _productTitleLabel.textAlignment = NSTextAlignmentJustified;
    }
    return _productTitleLabel;
}

-(UILabel *)productSpecsLabel{
    if (!_productSpecsLabel) {
        _productSpecsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _productSpecsLabel.textColor = [UIColor grayColor];
        _productSpecsLabel.font = [UIFont systemFontOfSize:13];
    }
    return _productSpecsLabel;
}

-(UILabel *)productPriceLabel{
    if (!_productPriceLabel) {
        _productPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _productPriceLabel.textAlignment = NSTextAlignmentRight;
        _productPriceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _productPriceLabel;
}

-(UILabel *)productQtyLabel{
    if (!_productQtyLabel) {
        _productQtyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _productQtyLabel.textAlignment = NSTextAlignmentRight;
        _productQtyLabel.font = [UIFont systemFontOfSize:13];
    }
    return _productQtyLabel;
}

@end
