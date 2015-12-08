//
//  CTView.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 3/12/2015.
//  Copyright © 2015 CHEN KAIDI. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>
@implementation CTView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable(); //1
    CGPathAddRect(path, NULL, self.bounds );
    
    NSAttributedString* attString = [[NSAttributedString alloc]
                                      initWithString:@"Hello core text world!"]; //2
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), path, NULL);
    
    CTFrameDraw(frame, context); //4
}


@end
