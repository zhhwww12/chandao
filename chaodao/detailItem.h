//
//  detailItem.h
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailItem : UIViewController
@property(nonatomic,retain)NSDictionary * oneDic;
@property (retain, nonatomic) IBOutlet UILabel *date;
@property (retain, nonatomic) IBOutlet UILabel *type;
@property (retain, nonatomic) IBOutlet UILabel *pri;
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *desc;


@property (retain, nonatomic) IBOutlet UILabel *state;
- (IBAction)compleItem:(id)sender;

@end
