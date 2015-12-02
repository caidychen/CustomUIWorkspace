//
//  PTEmojiInputView.h
//  PTLatitude
//
//  Created by CHEN KAIDI on 2/12/2015.
//  Copyright © 2015 PT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTEmojiInputView;

@protocol PTEmojiInputViewDelegate <NSObject>

@optional

- (void)emojiInputView:(PTEmojiInputView *)emojiInputView emojiTextDidChange:(NSString *)text;
- (void)backspaceTapped:(PTEmojiInputView *)emojiInputView;
- (void)sendTapped:(PTEmojiInputView *)emojiInputView;

@end

@interface PTEmojiInputView : UIView
@property (nonatomic, assign) id<PTEmojiInputViewDelegate>delegate;
@end
