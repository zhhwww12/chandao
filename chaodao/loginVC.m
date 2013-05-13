//
//  loginVC.m
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "loginVC.h"

@interface loginVC ()

@end

@implementation loginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"禅道登陆";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults * defaultDic = [NSUserDefaults standardUserDefaults];
    _serDrress.text = [defaultDic valueForKey:@"serverAddress"];
    _userNameTF.text = [defaultDic valueForKey:@"username"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userNameTF release];
    [_passWordTF release];
    [_loginBT release];
    [_serDrress release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserNameTF:nil];
    [self setPassWordTF:nil];
    [self setLoginBT:nil];
    [self setSerDrress:nil];
    [super viewDidUnload];
}
- (IBAction)loginChanDao:(id)sender {
    //保存服务器地址
    NSUserDefaults * defaultDic = [NSUserDefaults standardUserDefaults];
    [defaultDic setObject:_serDrress.text forKey:@"serverAddress"];
    [defaultDic setObject:_userNameTF.text forKey:@"username"];
    
   NSDictionary * dic =  [[httpLinker sharedHttpLinker] loginWithuserName:_userNameTF.text andpassword:_passWordTF.text];
    NSLog(@"dic = %@",dic);
    if([[dic objectForKey:@"status"] isEqualToString:@"success"])
    {
        RootViewController * iVC =[[RootViewController alloc] init];
        [self.navigationController pushViewController:iVC animated:YES];
        [iVC release];
    }
    else
    {
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"账号或者密码错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [alter release];
    }
   
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_userNameTF resignFirstResponder];
    [_passWordTF resignFirstResponder];
    [_serDrress resignFirstResponder];
}
@end
