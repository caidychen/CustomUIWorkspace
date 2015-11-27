//
//  PTOrderProductSummaryView.h
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTOrderProductSummaryItem.h"
@interface PTOrderProductSummaryView : UIView
-(void)setAttributeWithItem:(PTOrderProductSummaryItem *)item placeholderImage:(UIImage *)placeholderImage;
@end
