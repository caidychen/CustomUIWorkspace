//
//  PTAchievementBoardStandard.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 7/12/2015.
//  Copyright © 2015 CHEN KAIDI. All rights reserved.
//

#import "PTAchievementBoardStandard.h"
#import "PTAttributeStringTool.h"
#import "UIColor+Help.h"

@interface PTAchievementBoardStandard ()
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UILabel *bodyLabel;
@property (nonatomic, strong) UIImageView *themeIcon;
@property (nonatomic, strong) UIImageView *trophyIcon;
@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) UIView *footerBG;
@end

@implementation PTAchievementBoardStandard

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
        [self addSubview:self.headerLabel];
        [self addSubview:self.bodyLabel];
        [self addSubview:self.footerBG];
        [self addSubview:self.footerLabel];
        [self addSubview:self.themeIcon];
        [self addSubview:self.trophyIcon];
    }
    return self;
}

-(void)setAttributeWithCodeString:(NSString *)codeString icon:(NSString *)iconURL{
    NSArray *attributedStringSectionArray = [PTAttributeStringTool decompositeHTMLCode:codeString];
    NSInteger index = 0;
    if (attributedStringSectionArray.count == 3) {
        for(NSAttributedString *attributedString in attributedStringSectionArray){
            switch (index) {
                case 0:
                    self.headerLabel.attributedText = attributedString;
                    break;
                case 1:
                    self.bodyLabel.attributedText = attributedString;
                    break;
                case 2:
                    self.footerLabel.attributedText = attributedString;
                    break;
                    
                default:
                    break;
            }
            index++;
        }
        self.trophyIcon.hidden = YES;
        self.themeIcon.image = [UIImage imageNamed:iconURL];
        if (iconURL.length>0) {
            self.themeIcon.hidden = NO;
        }else{
            self.themeIcon.hidden = YES;
        }
        self.footerBG.hidden = NO;
    }else{
        self.themeIcon.hidden = YES;
        self.headerLabel.attributedText = [attributedStringSectionArray safeObjectAtIndex:0];
        self.footerLabel.attributedText = [attributedStringSectionArray safeObjectAtIndex:1];
        self.trophyIcon.image = [UIImage imageNamed:iconURL];
        self.footerBG.hidden = YES;
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(20, 20, 20, 20));
    self.headerLabel.frame = CGRectMake(0, 0, self.width, self.height/3-self.height/18);
    self.bodyLabel.frame = CGRectMake(0, self.headerLabel.bottom, self.width, self.height/3+self.height/18);
    self.footerBG.frame = CGRectMake(5, self.bodyLabel.bottom+5, self.width-10, self.height/3-10);
    self.footerLabel.frame = CGRectMake(inFrame.origin.x, self.bodyLabel.bottom, inFrame.size.width, self.height/3);
    self.themeIcon.frame = CGRectMake(self.width-10-20, 10, 20, 20);
    self.trophyIcon.frame = CGRectMake(0, 0, 60, 60);
    self.trophyIcon.center = CGPointMake(self.width/2, self.height/2);
}

-(UILabel *)headerLabel{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.textColor = [UIColor colorWithHexString:@"646464"];
        _headerLabel.font = [UIFont systemFontOfSize:12];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        //_headerLabel.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
    }
    return _headerLabel;
}

-(UILabel *)bodyLabel{
    if (!_bodyLabel) {
        _bodyLabel = [[UILabel alloc] init];
        _bodyLabel.textAlignment = NSTextAlignmentCenter;
        //_bodyLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        _bodyLabel.numberOfLines = 2;
    }
    return _bodyLabel;
}

-(UILabel *)footerLabel{
    if (!_footerLabel) {
        _footerLabel = [[UILabel alloc] init];
        _footerLabel.font = [UIFont systemFontOfSize:10];
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerLabel.numberOfLines = 2;
        //_footerLabel.backgroundColor = [UIColor whiteColor];
    }
    return _footerLabel;
}

-(UIView *)footerBG{
    if (!_footerBG) {
        _footerBG = [[UIView alloc] init];
        _footerBG.backgroundColor = [UIColor whiteColor];
    }
    return _footerBG;
}

-(UIImageView *)themeIcon{
    if (!_themeIcon) {
        _themeIcon = [[UIImageView alloc] init];
        _themeIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _themeIcon;
}

-(UIImageView *)trophyIcon{
    if (!_trophyIcon) {
        _trophyIcon = [[UIImageView alloc] init];
        _trophyIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _trophyIcon;
}

@end
