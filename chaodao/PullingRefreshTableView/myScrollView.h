//
//  myScrollView.h
//  chaodao
//
//  Created by wufuwei on 13-5-9.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myScrollViewDelegate <NSObject>

@optional
-(void)mytouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface myScrollView : UIScrollView


@property(assign,nonatomic)id<myScrollViewDelegate>mySdelegate;
@end
