//
//  RootViewController.m
//  chaodao
//
//  Created by wufuwei on 13-5-9.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize bilianArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //   
        self.bilianArray  = [NSArray arrayWithObjects:@"待定", nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登出" style:UIBarButtonItemStyleDone target:self action:@selector(logOutChanDao:)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _rootTableView.delegate =self;
    _rootTableView.dataSource  =self;
    // Do any additional setup after loading the view from its nib.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        itemVcViewController * iVC = [[itemVcViewController alloc] init];
        [self.navigationController pushViewController:iVC animated:YES];
        [iVC release];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bilianArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
	if (nil == cell)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.textLabel.text = [self.bilianArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)logOutChanDao:(id)sender
{
    [[httpLinker sharedHttpLinker] logOutChanDao];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [_rootTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setRootTableView:nil];
    [super viewDidUnload];
}
@end
