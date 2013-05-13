//
//  SLCheckBox.h
//  checkbox
//
//  Created by slook on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCheckBox : UIButton
{    
    BOOL _isChecked;
    
    id _target;
    SEL _func;
}

@property (nonatomic, assign)BOOL isChecked;

- (void)checkBoxClicked;
- (void)setTarget:(id)target func:(SEL)func;

@end
