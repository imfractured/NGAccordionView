//
//  NGAccordionBarView.m
//
//  Created by Nick Gorman on 2014-05-06.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "NGAccordionBarView.h"
#import "UIColor+HexColors.h"

@implementation NGAccordionBarView {
    UIImageView *arrow;
    BOOL isOpen;
}

@synthesize btn;
@synthesize container;
@synthesize fullHeight;
@synthesize minHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isOpen = NO;
        btn = [[UIButton alloc] init];
        [[btn layer] setBorderWidth:1.0f];
        [[btn layer] setBorderColor:[UIColor blackColor].CGColor];
        [btn.layer setMasksToBounds:YES];
        [btn setTitleColor: [UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        minHeight = self.frame.size.height;
        
    }
    return self;
}

CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
};

-(void)setTitle:(NSString*)title {

    // add the content first so its under the button
    container = [[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height,self.frame.size.width, 322)];
    [container setClipsToBounds:YES];
    [self addSubview:container];
    
    // add the button
    btn.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 26, 0, 0)]; // bottom, top, left, right
    [btn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:26]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.clipsToBounds=YES;
    fullHeight = container.frame.origin.y + container.frame.size.height;
}

-(void)setColor:(NSString*)str {
    btn.backgroundColor = [UIColor colorWithHexString:str];
}

-(void)setContent:(id)object {
    UIView *vw = (UIView*)object;
    [self.container addSubview:vw];
    fullHeight = vw.frame.size.height + container.frame.origin.y;
}

@end
