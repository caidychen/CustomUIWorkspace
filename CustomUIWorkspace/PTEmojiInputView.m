//
//  PTEmojiInputView.m
//  PTLatitude
//
//  Created by CHEN KAIDI on 2/12/2015.
//  Copyright © 2015 PT. All rights reserved.
//

#import "PTEmojiInputView.h"
#import "UIColor+Help.h"
#define kImageURL @"imageURL"
#define kCode @"code"
#define kIconSize 28
#define kRow 3
#define kColumn640px 7
#define kColumn750px 8
#define kColumn1242px 9
#define Screenwidth [UIScreen mainScreen].bounds.size.width
#define Screenheight [UIScreen mainScreen].bounds.size.height
#define kBottomPanelHeight 36
#define kSendButtonWidth 80
@interface PTEmojiInputView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSString *resultText;
@property (nonatomic, strong) NSMutableArray *emojiDictionaryList;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *bottomPanel;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) CGFloat spacing;
@end

@implementation PTEmojiInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.9 green:0.90 blue:0.9 alpha:1.0];
        self.emojiDictionaryList = [[NSMutableArray alloc] init];
        NSDictionary *basicDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"]];
        for(NSString *key in [basicDictionary allKeys]){
            [self.emojiDictionaryList addObject:[NSDictionary dictionaryWithObjectsAndKeys:[basicDictionary safeObjectForKey:key],key, nil]];
        }
        NSArray *sortedDict = [self.emojiDictionaryList sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *first, NSDictionary *second) {
            NSString *valueStringA = [first safeObjectForKey:[[first allKeys] safeObjectAtIndex:0]];
            NSString *valueStringB = [second safeObjectForKey:[[second allKeys] safeObjectAtIndex:0]];
            return [valueStringA compare:valueStringB]; 
        }];
        self.emojiDictionaryList = [[NSMutableArray alloc] initWithArray:sortedDict];
        self.resultText = [[NSMutableString alloc] init];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self addSubview:self.bottomPanel];
        [self.bottomPanel addSubview:self.sendButton];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.row = kRow;
    if (Screenwidth == 640/2) {
        self.column = kColumn640px;
    }else if (Screenwidth == 750/2){
        self.column = kColumn750px;
    }else if (Screenwidth == 1242/2){
        self.column = kColumn1242px;
    }
    self.spacing = (Screenwidth-kIconSize*self.column)/(self.column+1);
    self.scrollView.frame = self.bounds;
    NSInteger numberOfPage = ceilf((float)self.emojiDictionaryList.count/(float)(self.column*self.row));
    NSMutableArray *pageArray = [[NSMutableArray alloc] init];
    NSInteger currentIndex = 0;
    for (NSInteger i=0; i<numberOfPage; i++) {
        NSMutableArray *iconArray = [[NSMutableArray alloc] init];
        for (NSInteger j=currentIndex; j<currentIndex+self.column*self.row-1; j++) {
            if ([self.emojiDictionaryList safeObjectAtIndex:j]) {
                [iconArray addObject:[self.emojiDictionaryList safeObjectAtIndex:j]];
            }else{
                break;
            }
        }
        [pageArray addObject:iconArray];
        currentIndex+=self.column*self.row-1;
    }
    for (NSInteger i=0; i<numberOfPage; i++) {
        UIView *emojiBoardView = [self pageViewWithFrame:self.scrollView.frame withItem:[pageArray safeObjectAtIndex:i]atOffset:i*(self.column*self.row-1)];
        [self.scrollView addSubview:emojiBoardView];
        emojiBoardView.frame = CGRectMake(emojiBoardView.width*i, 0, emojiBoardView.width, emojiBoardView.height);
        [self.scrollView setContentSize:CGSizeMake(emojiBoardView.right, self.scrollView.height)];
    }
    self.pageControl.frame = CGRectMake(0, self.scrollView.bottom-20-kBottomPanelHeight, Screenwidth, 20);
    self.pageControl.numberOfPages = numberOfPage;
    self.pageControl.pageIndicatorTintColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.bottomPanel.frame = CGRectMake(0, self.scrollView.bottom-kBottomPanelHeight, Screenwidth, kBottomPanelHeight);
    self.sendButton.frame = CGRectMake(Screenwidth-kSendButtonWidth, 0, kSendButtonWidth, kBottomPanelHeight);
}

-(UIView *)pageViewWithFrame:(CGRect)frame withItem:(NSArray *)item atOffset:(NSInteger )offset{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    NSInteger row = 0;
    NSInteger column = 0;
    for (NSInteger i=0; i<item.count; i++) {
        UIButton *iconImageView = [[UIButton alloc] initWithFrame:CGRectMake(column*kIconSize+self.spacing*(column+1), row*kIconSize+self.spacing*(row+1), kIconSize, kIconSize)];
        [iconImageView setImage:[UIImage imageNamed:[[item objectAtIndex:i] safeObjectForKey:[[[item objectAtIndex:i] allKeys] objectAtIndex:0]]] forState:UIControlStateNormal] ;
        iconImageView.tag = offset+i;
        [iconImageView addTarget:self action:@selector(didTapIcon:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:iconImageView];
        if ((column+1)%self.column == 0) {
            column = 0;
            row++;
        }else{
            column++;
        }
    }
    UIButton *iconImageView = [[UIButton alloc] initWithFrame:CGRectMake(column*kIconSize+self.spacing*(column+1), row*kIconSize+self.spacing*(row+1), kIconSize, kIconSize)];
    [iconImageView setImage:[UIImage imageNamed:@"btn_f_delet_nor"] forState:UIControlStateNormal];
    [iconImageView setImage:[UIImage imageNamed:@"btn_f_delet_sel"] forState:UIControlStateHighlighted];
    [iconImageView addTarget:self action:@selector(didTapDelete) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:iconImageView];
    return view;
}

-(void)didTapIcon:(UIButton *)sender{
    NSString *currentText = [[self.emojiDictionaryList safeObjectAtIndex:sender.tag] safeObjectForKey:kCode];
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiInputView:emojiTextDidChange:)]) {
        [self.delegate emojiInputView:self emojiTextDidChange:currentText];
    }
    NSLog(@"emoji %@",currentText);
}

-(void)didTapDelete{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backspaceTapped:)]) {
        [self.delegate backspaceTapped:self];
    }
    NSLog(@"delete");
}

-(void)didTapSend{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendTapped:)]) {
        [self.delegate sendTapped:self];
    }
    NSLog(@"send");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPageIndex = self.scrollView.contentOffset.x/self.scrollView.width;
    self.pageControl.currentPage = currentPageIndex;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

-(UIView *)bottomPanel{
    if (!_bottomPanel) {
        _bottomPanel = [[UIView alloc] init];
        _bottomPanel.layer.borderWidth = 0.5;
        _bottomPanel.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor;
    }
    return _bottomPanel;
}

-(UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(didTapSend) forControlEvents:UIControlEventTouchUpInside];
        _sendButton.backgroundColor = [UIColor colorWithHexString:@"985ec9"];
    }
    return _sendButton;
}

@end
