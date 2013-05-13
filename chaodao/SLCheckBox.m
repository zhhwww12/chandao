//
//  SLCheckBox.m
//  checkbox
//
//  Created by slook on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


static const CGFloat checkBoxHeight = 20.0f;


#import "SLCheckBox.h"

@implementation SLCheckBox

#pragma mark - getter/setter

- (BOOL)isChecked
{
    return _isChecked;
}

- (void)setIsChecked:(BOOL)isChecked
{
    _isChecked = isChecked;
    UIImage * img = _isChecked ? [UIImage imageNamed:@"selectbox_yea_728.png"] : [UIImage imageNamed:@"selectbox_no_728.png"];
    [self setImage:img
          forState:UIControlStateNormal];
    
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = checkBoxHeight;
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;		
		//self.isChecked = NO;
        
		[self addTarget:self 
                 action:@selector(checkBoxClicked) 
       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void) checkBoxClicked
{
	self.isChecked = !_isChecked;
    if ([_target respondsToSelector:_func]) {
        [_target performSelector:_func];
    }
}

-(void)setTarget:(id)target func:(SEL)func
{
    if (target != _target) {
        [_target release];
        _target = [target retain];
    }
    _target = target;
    _func = func;
}

- (void)dealloc 
{
    [_target release];
    _target=nil;

    [super dealloc];
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
