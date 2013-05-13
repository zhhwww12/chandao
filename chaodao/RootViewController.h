//
//  RootViewController.h
//  chaodao
//
//  Created by wufuwei on 13-5-9.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemVcViewController.h"
@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * bilianArray;
}
@property (retain, nonatomic) IBOutlet UITableView *rootTableView;
@property (retain, nonatomic)  NSArray * bilianArray;

@end
