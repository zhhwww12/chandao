//
//  itemVcViewController.m
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "itemVcViewController.h"

@interface itemVcViewController ()

@end

@implementation itemVcViewController
@synthesize todosArray;
@synthesize dateArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        todosArray = [[NSMutableArray alloc] init];
        self.title = @"待办事项";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addoneItem:)];
    }
    return self;
}
-(void)addoneItem:(id)sneder
{
    addItemVC * aVC = [[addItemVC alloc] init];
    [self.navigationController pushViewController:aVC animated:YES];
    [aVC release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.todosArray = [[NSMutableArray alloc] init];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource  =self;

    
}

-(void)getNetWorkDate
{
    NSDictionary * daibanDic =  [[httpLinker sharedHttpLinker] getCmyDaiban];
    NSLog(@"daibandc = %@",daibanDic);
    NSString * newString = [daibanDic objectForKey:@"data"];
    NSDictionary * newDic = [newString JSONValue];
    //  todosArray
    NSArray * allTodoArray = [newDic objectForKey:@"todos"];
    
    [self organizationDate:allTodoArray];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self getNetWorkDate];
    [self.myTableView reloadData];
    
}
- (void)organizationDate:(NSArray*)allTodoArray
{
    
    [self.todosArray removeAllObjects];
    
    NSMutableSet * setArray = [[NSMutableSet alloc] init];
    for (int i = 0; i<allTodoArray.count; i++) {
        NSDictionary * oneDic = [allTodoArray objectAtIndex:i];
        NSString * dateString = [oneDic valueForKey:@"date"];
        NSDate * inputDate = [util getDateFromString:dateString andFromant:@"yyyy-MM-dd"];
        [setArray addObject:inputDate];
        
    }
    NSMutableArray * sortArray = [[NSMutableArray alloc] init];
    for (NSString * dateS in setArray) {
        [sortArray addObject:dateS];
    }
    [setArray release];
    
    
    
    NSArray * newSortArray = [sortArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSDate* t1 = obj1;
        NSDate* t2 = obj2;
       
        if([t1 compare:t2] == NSOrderedDescending )
        {
            return NSOrderedAscending;
        }
        else if([t1 compare:t2] == NSOrderedAscending)
        {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
        
    }];
    
     self.dateArray = newSortArray;
    [sortArray release];
    
    for (int i = 0; i<newSortArray.count; i++) {
        
        NSMutableArray * riqiArray =[[NSMutableArray alloc] init];
        for (int j = 0; j<allTodoArray.count; j++) {
            
            NSMutableDictionary * oneDic = [allTodoArray objectAtIndex:j];
            
            NSString * dateString = [oneDic valueForKey:@"date"];
            NSDate * date = [newSortArray objectAtIndex:i];
            
            NSString * oldDateString = [util getDateStringfordataFormant:@"yyyy-MM-dd" forData:date];
            
          
            if([dateString isEqualToString:oldDateString])
            {
                [riqiArray addObject:oneDic];
            }
        }
        [self.todosArray addObject:riqiArray];
        [riqiArray release];
        
    }
   
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dateArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 1;
    NSArray * array = [self.todosArray objectAtIndex:section];
    return array.count;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UIView * secTionView = [[UIView alloc] init];
    secTionView.backgroundColor = [UIColor grayColor];
    UILabel * datelable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    NSString * textString = [util getDateStringfordataFormant:@"yyyy-MM-dd" forData:[self.dateArray objectAtIndex:section]];
    datelable.text = textString;
    [datelable setTextColor:[UIColor whiteColor]];
    
    datelable.backgroundColor = [UIColor grayColor];
    datelable.textAlignment = NSTextAlignmentCenter;
    [secTionView addSubview:datelable];
    [datelable release];
    return [secTionView autorelease];
    

}
//封锁按钮点击
-(void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [[self.todosArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSNumber * idNumber = [dic valueForKey:@"id"];
    [[httpLinker sharedHttpLinker] delitemforId:idNumber];

  //  [self.todosArray removeObjectAtIndex:indexPath.row];
    
    NSMutableArray * array = [self.todosArray objectAtIndex:indexPath.section];
    [array removeObjectAtIndex:indexPath.row];
    [self.todosArray replaceObjectAtIndex:indexPath.section withObject:array];

    [self.myTableView reloadData];
}
-(NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
	itemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
	if (nil == cell)
	{
        cell = [[itemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell initData];
    }
    
    
    NSDictionary * dic = [[self.todosArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.priLable.text =[self getPriStringByPri:[dic objectForKey:@"pri"]];
    
    cell.nameLale.text = [dic objectForKey:@"name"];
    cell.descLable.text = [dic objectForKey:@"desc"];
    [cell.satusBt setTitle:[dic valueForKey:@"status"] forState:UIControlStateNormal];

    cell.satusBt.tag = [[dic valueForKey:@"id"] intValue];
    if([[dic valueForKey:@"status"] isEqualToString:@"done"])
    {
        cell.satusBt.userInteractionEnabled = NO;
      //  cell.satusBt.hidden = YES;
    }
    else
    {
        cell.satusBt.userInteractionEnabled = YES;
      //  cell.satusBt.hidden = NO;
    }
    [cell.satusBt addTarget:self action:@selector(compleItem:) forControlEvents:UIControlEventTouchUpInside];
        
    return cell;
}
-(NSString*)getPriStringByPri:(NSString *)pri
{
    if([pri isEqualToString:@"1"])
    {
        return @"[很/很]";
    }
    else if([pri isEqualToString:@"2"])
    {
        return @"[不/很]";
    }
    else if([pri isEqualToString:@"3"])
    {
        return @"[很/不]";
    }
    else
    {
        return @"[不/不]";
    }

}
- (void)compleItem:(UIButton*)sender {

    [[httpLinker sharedHttpLinker] compleitemforId:[NSNumber numberWithInt:sender.tag]];
    //根据id获取当前完成的事项所处的位置
    
    
 //   [self performSelector:@selector(reloadNetWork:) withObject:self afterDelay:2];
    
    
    NSIndexPath * senderIndex = [self getIndexforId:[NSNumber numberWithInt:sender.tag]];
    NSMutableArray * oldArray1 = [self.todosArray objectAtIndex:senderIndex.section];
    NSMutableDictionary * oldDic =[oldArray1 objectAtIndex:senderIndex.row];
    [oldDic setObject:@"done" forKey:@"status"];
    [oldArray1 replaceObjectAtIndex:senderIndex.row withObject:oldDic];
    [self.todosArray replaceObjectAtIndex:senderIndex.section withObject:oldArray1];
    NSArray * arr = [NSArray arrayWithObject:senderIndex];
    
    [self.myTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationLeft];
    
    
}
- (void)reloadNetWork:(id)sender
{
    
}
-(NSIndexPath*)getIndexforId:(NSNumber*)itemId
{
    int section,row;
   // self.todosArray
    
    for (int i = 0; i<self.todosArray.count; i++) {
        NSArray * dateA = [self.todosArray objectAtIndex:i];
       
        for (int j = 0; j<dateA.count; j++) {
            
            NSString * Nid =  [[dateA objectAtIndex:j] valueForKey:@"id"];
            NSString * newItem = [NSString stringWithFormat:@"%@",itemId];
           
        
            if([newItem isEqualToString:Nid])
            {
                row = j;
                NSLog(@"row = %d",row);
                NSLog(@"j = %d",j);
                section = i;
                break;
            }
        }
    }
    NSLog(@"row = %d,sention = %d",row,section);
    return [NSIndexPath indexPathForRow:row inSection:section];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * dic = [[todosArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    addItemVC * dVc = [[addItemVC alloc] init];
    dVc.oneDic = dic;
    [self.navigationController pushViewController:dVc animated:YES];
    [dVc release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyTableView:nil];
    [super viewDidUnload];
}

- (IBAction)testdaiban:(id)sender {
    
   
      
    
    
}
@end
