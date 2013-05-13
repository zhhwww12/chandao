//
//  itemVcViewController.h
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpLinker.h"
#import "addItemVC.h"
#import "JSON.h"
#import "detailItem.h"
#import "itemTableViewCell.h"
@interface itemVcViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray * todosArray;
        
}
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray * todosArray;
@property(nonatomic,retain)NSArray * dateArray;
- (IBAction)testdaiban:(id)sender;

@end
