//
//  TestCollectionViewCell.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 2/12/2015.
//  Copyright © 2015 CHEN KAIDI. All rights reserved.
//

#import "TestCollectionViewCell.h"

@interface TestCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TestCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageViewDefault"]];
    }
    return _imageView;
}

@end
