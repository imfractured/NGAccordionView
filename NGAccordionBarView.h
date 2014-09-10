//
//  NGAccordionBarView.h
//
//  Created by Nick Gorman on 2014-05-06.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface NGAccordionBarView : UIView

/** The button you press to initiate the accordion */
@property UIButton *btn;

/** The container which holds our content that appears hidden below the button */
@property (retain) UIView *container;

/** fullHeight of the view, including the button and content */
@property int fullHeight;

/** minHeight of the view, which is the totalHeight when accordion item is closed */
@property int minHeight;

/** setTitle
 
 Sets the title of the accordion item
 
 @param title The title
 */
-(void)setTitle:(NSString*)title;

/** setColor
 
 Sets the background color of the button
 
 @param str The color as hex string ie. @"ffcc00"
 */
-(void)setColor:(NSString*)str;

/** setContent
 
 Sets the content and calculates the new fullHeight
 
 @param object The object which we are appending to our accordion container ie. the content
 */

-(void)setContent:(id)object;

@end
