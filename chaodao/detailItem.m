//
//  detailItem.m
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "detailItem.h"

@interface detailItem ()

@end

@implementation detailItem
@synthesize oneDic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(bianjie:)];
        
    }
    return self;
}
-(void)bianjie:(id)sender
{
    _name.userInteractionEnabled = YES;
    _desc.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(tijiao:)];
}
-(void)tijiao:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_name setUserInteractionEnabled:NO];
    _desc.userInteractionEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_name resignFirstResponder];
    [_desc resignFirstResponder];
    
}
- (void)dealloc {
    [_date release];
    [_type release];
    [_pri release];
    [_name release];
   
    [_state release];
    [_desc release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDate:nil];
    [self setType:nil];
    [self setPri:nil];
    [self setName:nil];
    
    [self setState:nil];
    [self setDesc:nil];
    [super viewDidUnload];
}
- (IBAction)compleItem:(id)sender {
}
@end
