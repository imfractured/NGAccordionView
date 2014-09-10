//
//  NGAccordionView.m
//
//  Created by Nick Gorman on 2014-05-06.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#import "NGAccordionView.h"

@implementation NGAccordionView {
    NSMutableArray *items;
    NSInteger clipHeight;
    NSInteger currentlySelectedItem;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        currentlySelectedItem = 99999; // setting this as a hack to make sure the first button doesnt == 0
        self.clipsToBounds=YES;
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addObjectToAccordion:(NGAccordionBarView*)clip {
    
    clipHeight = clip.frame.size.height;
    
    clip.frame = CGRectMake(0,
                            [items count]*clipHeight,
                            clip.frame.size.width,
                            clip.frame.size.height
                            );

    [self addSubview:clip];
    [items addObject:clip];
    
    [clip.btn addTarget:self action:@selector(buttonCallback:) forControlEvents:UIControlEventTouchUpInside];
    clip.btn.tag = [items count]-1;
    
    self.contentSize = CGSizeMake(self.frame.size.width, [items count]*clipHeight);
}

-(void)buttonCallback:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self animateOpen:button.tag];
}

-(void)animateOpen:(NSInteger)number {
    NGAccordionBarView *bar = [items objectAtIndex:number];
    int heightOfOpenBox = bar.fullHeight;
    int totalHeightForContainer = 0;
    long yPosForItem = 0;
    int heightOfSelectedBox = 0;
    for ( int i = 0; i < [items count]; i++ ){
        if ( i != number ){
            
            NGAccordionBarView *midBar = [items objectAtIndex:i];
            
            int targetHeight = midBar.minHeight;
            int newYPosition = (targetHeight * i);
            if ( i > number ){
                newYPosition = newYPosition + heightOfOpenBox - targetHeight;
            }
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            midBar.frame = CGRectMake(midBar.frame.origin.x, newYPosition, midBar.frame.size.width, targetHeight);
            [UIView commitAnimations];
            
            totalHeightForContainer = totalHeightForContainer + targetHeight;
            
        } else {
            
            int targetHeight = bar.fullHeight;
            long newYPosition = (bar.minHeight * number);
            yPosForItem = newYPosition;
            heightOfSelectedBox = targetHeight;

            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            // close the view
            if ( currentlySelectedItem == number ){
                currentlySelectedItem = -1;
                bar.frame = CGRectMake(bar.frame.origin.x, newYPosition, bar.frame.size.width, bar.minHeight);
                heightOfOpenBox = bar.minHeight;
                totalHeightForContainer = totalHeightForContainer + bar.minHeight;
                heightOfSelectedBox = bar.minHeight;
                
            // open the proper view
            } else {
                currentlySelectedItem = number;
                bar.frame = CGRectMake(bar.frame.origin.x, newYPosition, bar.frame.size.width, targetHeight);
                totalHeightForContainer = totalHeightForContainer + targetHeight;
                heightOfSelectedBox = bar.minHeight;
            }

            [UIView commitAnimations];
        }
    }
    
    long newYPos = bar.minHeight * number;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.contentSize = CGSizeMake(self.frame.size.width, totalHeightForContainer);
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:.2
                                     target:self
                                   selector:@selector(setRect:)
                                   userInfo:[[NSNumber alloc] initWithLong:newYPos]
                                    repeats:NO];
    
}

-(void)setRect:(NSTimer*)theTimer {
    UIView *vw = self.superview;
    [self scrollRectToVisible: CGRectMake(0,(CGFloat)[[theTimer userInfo] longValue],self.frame.size.width,vw.frame.size.height) animated:YES];
}

@end
