//
//  itemTableViewCell.h
//  chaodao
//
//  Created by wufuwei on 13-5-9.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itemTableViewCell : UITableViewCell
@property(nonatomic,retain)UILabel * nameLale;
@property(nonatomic,retain)UIButton * satusBt;
@property(nonatomic,retain)UILabel * descLable;
@property(nonatomic,retain)UILabel * priLable;

- (void) initData;
@end
