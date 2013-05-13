//
//  myScrollView.m
//  chaodao
//
//  Created by wufuwei on 13-5-9.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "myScrollView.h"

@implementation myScrollView
@synthesize mySdelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mySdelegate mytouchesBegan:touches withEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
