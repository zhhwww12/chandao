//
//  itemTableViewCell.m
//  chaodao
//
//  Created by wufuwei on 13-5-9.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "itemTableViewCell.h"

@implementation itemTableViewCell
@synthesize nameLale;
@synthesize descLable;
@synthesize satusBt;
@synthesize priLable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
    }
    return self;
}
- (void) initData
{
    
    //优先级lable
    priLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    priLable.textAlignment = NSTextAlignmentCenter;
    [priLable setFont:[UIFont boldSystemFontOfSize:11]];
   // [priLable setTextColor:[]
    [self.contentView addSubview:priLable];
    
    //名字lale
    nameLale = [[[UILabel alloc] initWithFrame:CGRectMake(45, 0, 200, 22)] autorelease];
    nameLale.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:nameLale];
 
    //描述leble
    descLable = [[[UILabel alloc] initWithFrame:CGRectMake(45, 22, 200, 22)] autorelease];
    descLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:descLable];
   
    
    //状态lable
    satusBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    satusBt.frame = CGRectMake(250, 7, 60, 30);
    [self.contentView addSubview:satusBt];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
