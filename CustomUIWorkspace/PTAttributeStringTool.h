//
//  PTAttributeStringTool.h
//  PTLatitude
//
//  Created by CHEN KAIDI on 2/12/2015.
//  Copyright © 2015 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTAttributeStringTool : NSObject
+(NSMutableAttributedString *)convertEmojiWithAttributedString:(NSAttributedString *)attributedString contentDictionary:(NSDictionary *)contentDictionary;
+(NSArray *)decompositeHTMLCode:(NSString *)code;
@end
