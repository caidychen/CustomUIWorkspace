//
//  PTAttributeStringTool.m
//  PTLatitude
//
//  Created by CHEN KAIDI on 2/12/2015.
//  Copyright © 2015 PT. All rights reserved.
//

#import "PTAttributeStringTool.h"
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
        attachment.image = [UIImage imageNamed:[contentDictionary safeObjectForKey:[attributedString.string substringWithRange:matchRange]]];
        attachment.bounds = CGRectMake(0, ([UIFont systemFontOfSize:16].pointSize-[UIFont systemFontOfSize:16].lineHeight)/2, [UIFont systemFontOfSize:16].pointSize, [UIFont systemFontOfSize:16].pointSize);
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [mutableAttributedString replaceCharactersInRange:matchRange withAttributedString:attachmentString];
    }];

    return mutableAttributedString;
}


@end
