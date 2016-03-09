//
//  DemoViewController.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import "DemoViewController.h"
#import "PTCustomMenuSliderView.h"
#import "PTOrderProductSummaryItem.h"
#import "PTOrderProductSummaryView.h"
#import "PTOrderStateView.h"
#import "PTEmojiInputView.h"
#import "PTAttributeStringTool.h"
#import "CTView.h"
#import "PTAchievementBoardStandard.h"
#import "SOLoadingView.h"
#define kImageURL @"imageURL"
#define kCode @"code"

#define Screenwidth [UIScreen mainScreen].bounds.size.width
#define Screenheight [UIScreen mainScreen].bounds.size.height
@interface DemoViewController ()<PTCustomMenuSliderViewDelegate,UITextViewDelegate, PTEmojiInputViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) PTEmojiInputView *emojiView;
@property (nonatomic, strong) NSDictionary *emojiDictionaryList;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 250, 250)];
    view.backgroundColor = [UIColor redColor];
    view.layer.cornerRadius = view.frame.size.width/2;
    [self.view addSubview:view];
    
    //create an animation to follow a circular path
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //interpolate the movement to be more smooth
    pathAnimation.calculationMode = kCAAnimationPaced;
    //apply transformation at the end of animation (not really needed since it runs forever)
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    //run forever
    pathAnimation.repeatCount = INFINITY;
    //no ease in/out to have the same speed along the path
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 5.0;
    
    //The circle to follow will be inside the circleContainer frame.
    //it should be a frame around the center of your view to animate.
    //do not make it to large, a width/height of 3-4 will be enough.
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(view.frame, view.width/2-20, view.height/2-20);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    
    //add the path to the animation
    pathAnimation.path = curvedPath;
    //release path
    CGPathRelease(curvedPath);
    //add animation to the view's layer
    [view.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
    
    
    //create an animation to scale the width of the view
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    //set the duration
    scaleX.duration = 1;
    //it starts from scale factor 1, scales to 1.05 and back to 1
    scaleX.values = @[@1.0, @1.05, @1.0];
    //time percentage when the values above will be reached.
    //i.e. 1.05 will be reached just as half the duration has passed.
    scaleX.keyTimes = @[@0.0, @0.5, @1.0];
    //keep repeating
    scaleX.repeatCount = INFINITY;
    //play animation backwards on repeat (not really needed since it scales back to 1)
    scaleX.autoreverses = YES;
    //ease in/out animation for more natural look
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //add the animation to the view's layer
    [view.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    
    //create the height-scale animation just like the width one above
    //but slightly increased duration so they will not animate synchronously
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = 1.5;
    scaleY.values = @[@1.0, @1.05, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = INFINITY;
    scaleY.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
}

-(void)startEmoji{
    [self.view addSubview:self.textView];
    self.textView.inputView = self.emojiView;
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"001.png"];
    attachment.bounds = CGRectMake(0, ([UIFont systemFontOfSize:16].pointSize-[UIFont systemFontOfSize:16].lineHeight)/2, [UIFont systemFontOfSize:16].pointSize, [UIFont systemFontOfSize:16].pointSize);
    NSString *text = @"My label text ";
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:text];
    [myString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, [text length])];
    [myString appendAttributedString:attachmentString];
    
    
    self.emojiDictionaryList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"]];
    
    
    NSString *testString = @"这是一句测试[大笑][发怒]";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:testString];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, [attributedString length])];
    attributedString = [PTAttributeStringTool convertEmojiWithAttributedString:attributedString contentDictionary:self.emojiDictionaryList];
    self.textView.attributedText = attributedString;
}

-(NSAttributedString *)highlightNicknameForText:(NSString *)inputText withFont:(UIFont *)font{
    
    if (inputText.length == 0) {
        return nil;
    }
    
    NSString *text = inputText;
    
    // This will give me an attributedString with the base text-style
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSString *regularExpression = @"\\[\\w+\\]";
 
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, text.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attributedString length])];
    
    [matches enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange matchRange = [obj rangeAtIndex:0];
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:[self getImageURLPathfromEmojiCode:[inputText substringWithRange:matchRange]]];
        attachment.bounds = CGRectMake(0, ([UIFont systemFontOfSize:16].pointSize-[UIFont systemFontOfSize:16].lineHeight)/2, [UIFont systemFontOfSize:16].pointSize, [UIFont systemFontOfSize:16].pointSize);
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        [attributedString replaceCharactersInRange:matchRange withAttributedString:attachmentString];    }];

    return attributedString;
}

-(NSString *)getImageURLPathfromEmojiCode:(NSString *)code{
    NSString *imageURL = @"";
    for(NSDictionary *dict in self.emojiDictionaryList){
        if ([[dict safeObjectForKey:kCode] isEqualToString:code]) {
            imageURL = [dict safeObjectForKey:kImageURL];
            break;
        }
    }
    return imageURL;
}

-(void)emojiTextDidChange:(NSString *)text{
    NSLog(@"text %@",text);
}

-(void)sliderView:(PTCustomMenuSliderView *)sliderView didSelecteAtIndex:(NSInteger)index{
    NSLog(@"PTCustomMenuSliderView: did selecte on index:%ld",(long)index);
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 50, Screenwidth, 100)];
        _textView.delegate = self;
    }
    return _textView;
}

-(PTEmojiInputView *)emojiView{
    if (!_emojiView) {
        _emojiView = [[PTEmojiInputView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, 216)];
    }
    return _emojiView;
}

@end
