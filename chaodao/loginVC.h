//
//  loginVC.h
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpLinker.h"
#import "itemVcViewController.h"
#import "RootViewController.h"
@interface loginVC : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *userNameTF;
@property (retain, nonatomic) IBOutlet UITextField *passWordTF;
@property (retain, nonatomic) IBOutlet UIButton *loginBT;
- (IBAction)loginChanDao:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *serDrress;

@end
