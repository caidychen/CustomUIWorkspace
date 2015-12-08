//
//  PTAttributeStringTool.m
//  PTLatitude
//
//  Created by CHEN KAIDI on 2/12/2015.
//  Copyright © 2015 PT. All rights reserved.
//

#import "PTAttributeStringTool.h"
#import "UIColor+Help.h"
#define kImageURL @"imageURL"
#define kCode @"code"

@implementation PTAttributeStringTool


+(NSMutableAttributedString *)convertEmojiWithAttributedString:(NSAttributedString *)attributedString contentDictionary:(NSDictionary *)contentDictionary{


    NSString *regularExpression = @"\\[\\w+\\]";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
    NSArray *matches = [regex matchesInString:attributedString.string
                                      options:0
                                        range:NSMakeRange(0, attributedString.string.length)];

    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    [matches enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange matchRange = [obj rangeAtIndex:0];
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        //attachment.image = [UIImage imageNamed:[contentDictionary safeObjectForKey:[attributedString.string substringWithRange:matchRange]]];
        attachment.bounds = CGRectMake(0, ([UIFont systemFontOfSize:16].pointSize-[UIFont systemFontOfSize:16].lineHeight)/2, [UIFont systemFontOfSize:16].pointSize, [UIFont systemFontOfSize:16].pointSize);
        NSLog(@"%f %f %f %f",attachment.bounds.origin.x,attachment.bounds.origin.y,attachment.bounds.size.width,attachment.bounds.size.height);
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [mutableAttributedString replaceCharactersInRange:matchRange withAttributedString:attachmentString];
    }];

    return mutableAttributedString;
}

+(NSArray *)decompositeHTMLCode:(NSString *)code{
    
    //百分号转译
    code = [code stringByReplacingOccurrencesOfString:@"%" withString:@"PTModulus"];
    code = [code stringByReplacingOccurrencesOfString:@"/" withString:@"PTSlash"];
    
    //**********************Searching strings components**********************//
    NSArray *basicComponents = [code componentsSeparatedByString:@"<br>"];
    NSInteger index = 0;
    NSMutableArray *textComponents = [[NSMutableArray alloc] init];
    for(NSString *substring in basicComponents){
        NSString *regularExpression = @">\\w+<|>\n\\w+<";
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
        NSArray *matches = [regex matchesInString:substring
                                          options:0
                                            range:NSMakeRange(0, substring.length)];
        NSMutableArray *localTextGroup = [[NSMutableArray alloc] init];
        for (NSTextCheckingResult *match in matches){
            
            NSRange matchRange = [match rangeAtIndex:0];
           NSString *matchString = [substring substringWithRange:matchRange];
            matchString = [matchString stringByReplacingOccurrencesOfString:@"<" withString:@""];
            matchString = [matchString stringByReplacingOccurrencesOfString:@">" withString:@""];
            matchString = [matchString stringByReplacingOccurrencesOfString:@"bold" withString:@""];
            matchString = [matchString stringByReplacingOccurrencesOfString:@"PTModulus" withString:@"%"];
            matchString = [matchString stringByReplacingOccurrencesOfString:@"PTSlash" withString:@"/"];
            [localTextGroup addObject:matchString];
        }
        [textComponents addObject:localTextGroup];
        
        index++;
    }
   // NSLog(@"Global Components :%@",textComponents);
    
    //**********************Searching font settings components**********************//
    NSMutableArray *fontComponents = [[NSMutableArray alloc] init];
    NSString *regularExpression = @"<font color=\\w+ size=\\w+>|<font color=\\w+ size=\\w+ bold>";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
    NSArray *matches = [regex matchesInString:code
                                      options:0
                                        range:NSMakeRange(0, code.length)];
    for (NSTextCheckingResult *match in matches){
        
        NSRange matchRange = [match rangeAtIndex:0];
        NSString *matchString = [code substringWithRange:matchRange];
        matchString = [matchString stringByReplacingOccurrencesOfString:@"<" withString:@""];
        matchString = [matchString stringByReplacingOccurrencesOfString:@">" withString:@""];
        NSString *colorValueString = @"";
        NSString *sizeValueString = @"";
        NSString *boldValueString = @"";
        NSArray *fontSettings = [matchString componentsSeparatedByString:@" "];
        for(NSString *fontSettingComponents in fontSettings){
            
            if ([fontSettingComponents containsString:@"color="]) {
                colorValueString = [fontSettingComponents stringByReplacingOccurrencesOfString:@"color=" withString:@""];
            }
            if ([fontSettingComponents containsString:@"size="]) {
                sizeValueString = [fontSettingComponents stringByReplacingOccurrencesOfString:@"size=" withString:@""];
            }
            if ([fontSettingComponents containsString:@"bold"]) {
                boldValueString = fontSettingComponents;
            }
            
        }
        NSDictionary *fontSettingsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:colorValueString,@"color",sizeValueString,@"size",boldValueString,@"bold", nil];
        
       // NSLog(@"Font:%@",fontSettingsDictionary);
        [fontComponents addObject:fontSettingsDictionary];
    }
    
    //**********************Combining text with Settings**********************//
    NSInteger fontSettingIndex = 0;
    NSMutableArray *attributedStringGroupResult = [[NSMutableArray alloc] init];
    for(NSArray *textGroup in textComponents){
        NSMutableAttributedString *attributedStringComplete = [[NSMutableAttributedString alloc] init];
        for(NSString *text in textGroup){
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
            NSDictionary *fontSetting = [fontComponents safeObjectAtIndex:fontSettingIndex];
            if ([[fontSetting safeObjectForKey:@"bold"] isEqualToString:@"bold"]) {
                [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldMT" size:[[fontSetting safeObjectForKey:@"size"] floatValue]] range:NSMakeRange(0, [attributedString length])];
            }else{
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[[fontSetting safeObjectForKey:@"size"] floatValue]] range:NSMakeRange(0, [text length])];
            }
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:[fontSetting safeObjectForKey:@"color"]] range:NSMakeRange(0, [text length])];
            [attributedStringComplete appendAttributedString:attributedString];
            fontSettingIndex++;
        }
        [attributedStringGroupResult addObject:attributedStringComplete];
    }
    NSLog(@"Attribute %@",attributedStringGroupResult);
    return attributedStringGroupResult;
}

@end
