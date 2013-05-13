//
//  addItemVC.h
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpLinker.h"
#import "SLCheckBox.h"
#import "myScrollView.h"
#import "util.h"
@interface addItemVC : UIViewController<myScrollViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *_inputAccessoryView;
    UIDatePicker* _datePicker;
    UIPickerView *_genderPickerView;
    
    SLCheckBox * timeSelect;
    SLCheckBox * DateSelect;
    SLCheckBox * privateSelect;
   

}
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *desc;
@property (nonatomic,retain)NSMutableDictionary  * itemDic;
@property(nonatomic,retain)NSMutableDictionary * oneDic;
- (void)saveItem:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *itemdate;
@property (retain, nonatomic) IBOutlet UITextField *itemType;
@property (retain, nonatomic) IBOutlet UITextField *itemPri;

@property (retain, nonatomic) IBOutlet UITextField *descText;
@property (retain, nonatomic) IBOutlet UITextField *stateText;
@property (retain, nonatomic) IBOutlet UITextField *startTime;
@property (retain, nonatomic) IBOutlet UITextField *endTime;
@property (retain, nonatomic) IBOutlet SLCheckBox *timingOk;
@property (retain, nonatomic) IBOutlet SLCheckBox *privateOk;
@property (retain, nonatomic) IBOutlet myScrollView *myScrollView;

@property (retain, nonatomic) IBOutlet SLCheckBox *itemDateOk;
- (IBAction)compleItem:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *compleButton;

@end
