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
    // Do any additional setup after loading the view.
    PTAchievementBoardStandard *board = [[PTAchievementBoardStandard alloc] initWithFrame:CGRectMake(0, 0, self.view.width/2, self.view.width/2/299*268)];
    [board setAttributeWithCodeString:@"<font color=646464 size=14>昨日30分钟拼完</font><br><font color=313131 size=30>100</font><font color=313131 size=14>个</font><font color=646464 size=14>\n七巧板</font><br><font color=959595 size=12>平均速度</font><font color=646464 size=12 bold>超越了90%</font><font color=959595 size=12>的孩子</font>" icon:@"040"];
    board.center = self.view.center;
    [self.view addSubview:board];
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
    
    clock_t s = clock();
    
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
    
    clock_t e = clock();

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
