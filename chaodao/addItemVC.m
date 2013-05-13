//
//  addItemVC.m
//  chaodao
//
//  Created by wufuwei on 13-5-8.
//  Copyright (c) 2013年 wufuwei. All rights reserved.
//

#import "addItemVC.h"

@interface addItemVC ()

@end

@implementation addItemVC
@synthesize itemDic;
@synthesize oneDic;
//#define importtantLevel;
//
//typedef NS_ENUM(NSInteger, im) {
//    UIBarButtonItemStylePlain,    // shows glow when pressed
//    UIBarButtonItemStyleBordered,
//    UIBarButtonItemStyleDone,
//};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if(oneDic!=nil)
    {
        NSString * staus = [oneDic objectForKey:@"status"];
        if([staus isEqualToString:@"done"])
        {
          _compleButton.hidden = YES;  
        }
        else
        {
            _compleButton.hidden = NO;
        }
       
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if(oneDic==nil)
    {
        NSDate * date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _itemdate.text = [dateFormatter stringFromDate:date];
        
        [dateFormatter setDateFormat:@"HH:MM"];
        _startTime.text = [dateFormatter stringFromDate:date];

        NSDate * newDate = [NSDate dateWithTimeIntervalSinceNow:30*60];
        [dateFormatter setDateFormat:@"HH:MM"];
        _endTime.text = [dateFormatter stringFromDate:newDate];
        [dateFormatter release];
        _itemType.text = @"custom";
        _itemPri.text = @"很重要/不紧急";
        _stateText.text = @"wait";
        [self.itemDic setObject:_itemdate.text forKey:@"date"];
        [self.itemDic setObject:@"custom" forKey:@"type"];
        [self.itemDic setObject:@"3" forKey:@"pri"];
        [self.itemDic setObject:@"wait" forKey:@"status"];
        [self.itemDic setObject:_endTime.text  forKey:@"begin"];
        [self.itemDic setObject:_endTime.text  forKey:@"end"];
        [self.itemDic setObject:UNDT_DATE forKey:@"private"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveItem:)];
    }
    else
    {
        //初始化值
        _itemdate.text = [oneDic objectForKey:@"date"];
        _itemType.text = [oneDic objectForKey:@"type"];
        
        _itemPri.text = [self getPriStringByNumber:[oneDic objectForKey:@"pri"]];
        
        _name.text = [oneDic objectForKey:@"name"];
        _desc.text = [oneDic objectForKey:@"desc"];
        _stateText.text = [oneDic objectForKey:@"status"];
        _startTime.text = [oneDic objectForKey:@"begin"];
        _endTime.text = [oneDic objectForKey:@"end"];
        //关闭控件的交互
        _itemdate.userInteractionEnabled = NO;
        _itemType.userInteractionEnabled = NO;
        _itemPri.userInteractionEnabled = NO;
        _name.userInteractionEnabled = NO;
        _desc.userInteractionEnabled = NO;
        _stateText.userInteractionEnabled = NO;
        _startTime.userInteractionEnabled = NO;
        _endTime.userInteractionEnabled = NO;
        DateSelect.userInteractionEnabled = NO;
        timeSelect.userInteractionEnabled = NO;
        privateSelect.userInteractionEnabled = NO;
        //编辑按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(bianjie:)];
        
    }

}
- (NSString*)getPriStringByNumber:(NSString*)pri
{
    if([pri isEqualToString:@"1"])
    {
        return @"很重要/很紧急";
    }
    else if([pri isEqualToString:@"2"])
    {
        return @"不重要/很紧急";
    }
    else if([pri isEqualToString:@"3"])
    {
        return @"很重要/不紧急";
    }
    else 
    {
        return @"不重要/不紧急";
    }

}
-(void)bianjie:(id)sender
{
    //打开控件的交互
    _itemdate.userInteractionEnabled = YES;
    _itemType.userInteractionEnabled = YES;
    _itemPri.userInteractionEnabled = YES;
    _name.userInteractionEnabled = YES;
    _desc.userInteractionEnabled = YES;
    _stateText.userInteractionEnabled = YES;
    _startTime.userInteractionEnabled = YES;
    _endTime.userInteractionEnabled = YES;
    DateSelect.userInteractionEnabled = YES;
    timeSelect.userInteractionEnabled = YES;
    privateSelect.userInteractionEnabled = YES;
    //显示完成按钮

    _compleButton.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更改" style:UIBarButtonItemStyleDone target:self action:@selector(modifyItem:)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化数据
    self.itemDic = [NSMutableDictionary dictionaryWithCapacity:10];
    
    
     //定义scolliew
    _myScrollView.mySdelegate = self;
    _myScrollView.userInteractionEnabled = YES;
    _myScrollView.frame =CGRectMake(0, 144, 320, self.view.frame.size.height);
    [_myScrollView setContentSize:CGSizeMake(320, 1000)];
    _myScrollView.pagingEnabled = NO;
    //添加代理
    _itemdate.delegate =self;
    _itemType.delegate = self;
    _itemPri.delegate = self;
    _name.delegate = self;
    _desc.delegate = self;
    _stateText.delegate =self;
    _startTime.delegate =self;
    _endTime.delegate = self;
    //单选按钮
    //日期待定
    DateSelect = [[SLCheckBox alloc] initWithFrame:CGRectMake(263, 24, 60, 30)];
    //默认不被点击
    DateSelect.isChecked = NO; //default is NO
    DateSelect.tag = 101;
    [DateSelect addTarget:self action:@selector(SLCLicked:) forControlEvents:UIControlEventTouchUpInside];
    DateSelect.titleLabel.font = [UIFont systemFontOfSize:12];
    [DateSelect setTitle:@"待定" forState:UIControlStateNormal];
    [DateSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myScrollView addSubview:DateSelect];
    [DateSelect release];
    //是否设定更新时间
    timeSelect = [[SLCheckBox alloc] initWithFrame:CGRectMake(100, 330, 150, 30)];
    //默认不被点击
    timeSelect.isChecked = NO; //default is NO
    timeSelect.tag = 102;
    [timeSelect addTarget:self action:@selector(SLCLicked:) forControlEvents:UIControlEventTouchUpInside];
    timeSelect.titleLabel.font = [UIFont systemFontOfSize:12];
    [timeSelect setTitle:@"暂时不设定时间" forState:UIControlStateNormal];
    [timeSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myScrollView addSubview:timeSelect];
    [timeSelect release];
    //是否是私人事务
    
    privateSelect = [[SLCheckBox alloc] initWithFrame:CGRectMake(100, 430,30, 30)];
    //默认不被点击
    privateSelect.isChecked = NO; //default is NO
    privateSelect.tag = 103;
     [privateSelect addTarget:self action:@selector(SLCLicked:) forControlEvents:UIControlEventTouchUpInside];
    privateSelect.titleLabel.font = [UIFont systemFontOfSize:12];
    [privateSelect setTitle:@"" forState:UIControlStateNormal];
    [privateSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myScrollView addSubview:privateSelect];
    [privateSelect release];

    
    
}
-(void)SLCLicked:(SLCheckBox*)sender
{
    
    if(sender.tag == 101)
    {
        if(sender.isChecked == YES)
        {
            _itemdate.userInteractionEnabled = NO;
            [_itemdate setTextColor:[UIColor grayColor]];
            [self.itemDic setObject:UNDT_DATE forKey:@"date"];
            [oneDic setObject:UNDT_DATE forKey:@"date"];
            
        }
        else
        {
            _itemdate.userInteractionEnabled = YES;
            [_itemdate setTextColor:[UIColor blackColor]];
            [self.itemDic setObject:_itemdate.text forKey:@"date"];
            [oneDic setObject:_itemdate.text forKey:@"date"];
        }
    }
    else if(sender.tag == 102)
    {
        if(sender.isChecked == YES)
        {
            _startTime.userInteractionEnabled = NO;
            _endTime.userInteractionEnabled = NO;
            [_startTime setTextColor:[UIColor grayColor]];
            [_endTime setTextColor:[UIColor grayColor]];
            
            [self.itemDic setObject:UNDT_DATE forKey:@"begin"];
            [oneDic setObject:UNDT_DATE forKey:@"begin"];
            [self.itemDic setObject:UNDT_DATE forKey:@"end"];
            [oneDic setObject:UNDT_DATE forKey:@"end"];
        }
        else
        {
            _startTime.userInteractionEnabled = YES;
            _endTime.userInteractionEnabled = YES;
            [_startTime setTextColor:[UIColor blackColor]];
            [_endTime setTextColor:[UIColor blackColor]];
            [self.itemDic setObject:_startTime.text forKey:@"begin"];
            [oneDic setObject:_startTime.text forKey:@"begin"];
            [self.itemDic setObject:_endTime.text forKey:@"end"];
            [oneDic setObject:_endTime.text forKey:@"end"];
        }
    }
    else
    {
        if(sender.isChecked == YES)
        {
            [self.itemDic setObject:@"1" forKey:@"private"];
            [oneDic setObject:@"1" forKey:@"private"];
        }
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField.tag == 10)
    {

        _datePicker = [[UIDatePicker alloc] init];
       
        
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_datePicker setMaximumDate:[NSDate date]];
        NSString * dateString = [oneDic valueForKey:@"date"];
         NSDate * inputDate = [util getDateFromString:dateString andFromant:@"yyyy-MM-dd"];
        _datePicker.date = inputDate;
        _datePicker.tag = textField.tag;
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        textField.inputView = _datePicker;
        
        [_datePicker release];
        
    }
    else if(textField.tag ==11||textField.tag == 12 ||textField.tag == 15)
    {
        _genderPickerView = [[UIPickerView alloc] init];
        _genderPickerView.delegate =self;
        _genderPickerView.dataSource = self;
        _genderPickerView.showsSelectionIndicator = YES;
        _genderPickerView.tag = textField.tag;
       
        
        textField.inputView = _genderPickerView;
        [_genderPickerView release];

    }
    else if(textField.tag  == 16)
    {
        _datePicker = [[UIDatePicker alloc] init];
        
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
        [_datePicker setMaximumDate:[NSDate date]];
        
        NSString * dateString = [oneDic valueForKey:@"begin"];
        NSDate * date = [util getDateFromString:dateString andFromant:@"HH:mm"];
        _datePicker.date = date;
        
        
        _datePicker.tag = textField.tag;
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        textField.inputView = _datePicker;
        [_datePicker release];
    }
    else if (textField.tag == 17)
    {
        _datePicker = [[UIDatePicker alloc] init];
        
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
        [_datePicker setMaximumDate:[NSDate date]];
        NSString * dateString = [oneDic valueForKey:@"end"];
        NSDate * date = [util getDateFromString:dateString andFromant:@"HH:mm"];
        _datePicker.date = date;
        _datePicker.tag = textField.tag;
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        textField.inputView = _datePicker;
        [_datePicker release];
    }
  

}
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (11== pickerView.tag)
    {
        return 1;
    }
    else if(pickerView.tag == 12)
    {
        return 1;
    }
    else if(pickerView.tag == 15)
    {
        return 1;
    }
    
    
    return 0;
}
- (NSInteger) pickerView: (UIPickerView *)pickerView
 numberOfRowsInComponent: (NSInteger) component
{
    if (pickerView.tag == 11)
    {
        return 3;
    }
    else if(pickerView.tag == 12)
    {
        return 4;
    }
    else if(pickerView.tag ==15)
    {
        return 3;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if(pickerView.tag ==11)
    {
        switch (row)
        {
            case 0:
                return @"custom";
                break;
            case 1:
                return @"Bug";
                break;
            case 2:
                return @"项目任务";
                break;
            default:
                break;
        }
    }
    else if(pickerView.tag ==12)
    {
        switch (row)
        {
            case 0:
                return @"很重要/不紧急";
                break;
            case 1:
                return @"很重要/很紧急";
                break;
            case 2:
                return @"不重要/很紧急";
                break;
            case 3:
                return @"不重要/不紧急";
                break;
            default:
                break;
        }
    }
    else if(pickerView.tag == 15)
    {
        switch (row)
        {
            case 0:
                return @"wait";
                break;
            case 1:
                return @"doing";
                break;
            case 2:
                return @"done";
                break;
            default:
                break;
        }
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (11 == pickerView.tag)
    {
        switch (row)
        {
            case 0:
                _itemType.text = @"custom";
                [self.itemDic setObject:@"custom" forKey:@"type"];
                break;
            case 1:
                _itemType.text = @"Bug";
                [self.itemDic setObject:@"custom" forKey:@"type"];
                break;
            case 2:
                _itemType.text = @"项目任务";
                [self.itemDic setObject:@"custom" forKey:@"type"];
                break;
            default:
                break;
        }
    }
    else if(pickerView.tag ==12)
    {
        switch (row)
        {
            case 0:
                _itemPri.text =  @"很重要/不紧急";
                [self.itemDic setObject:@"3" forKey:@"pri"];
                [oneDic setObject:@"3" forKey:@"pri"];
                break;
            case 1:
                _itemPri.text = @"很重要/很紧急";
                [self.itemDic setObject:@"1" forKey:@"pri"];
                [oneDic setObject:@"1" forKey:@"pri"];
                break;
            case 2:
                _itemPri.text =  @"不重要/很紧急";
                [self.itemDic setObject:@"2" forKey:@"pri"];
                [oneDic setObject:@"2" forKey:@"pri"];
                break;
            case 3:
                _itemPri.text =  @"不重要/不紧急";
                [self.itemDic setObject:@"4" forKey:@"pri"];
                [oneDic setObject:@"4" forKey:@"pri"];
                break;
            default:
                break;
        }
    }
    else if(pickerView.tag == 15)
    {
        switch (row)
        {
            case 0:
                _stateText.text = @"wait";
                [self.itemDic setObject:@"wait" forKey:@"status"];
                [oneDic setObject:@"wait" forKey:@"status"];
                break;
            case 1:
                _stateText.text =  @"doing";
                [self.itemDic setObject:@"doing" forKey:@"status"];
                [oneDic setObject:@"doing" forKey:@"status"];
                break;
            case 2:
                _stateText.text =  @"done";
                [self.itemDic setObject:@"done" forKey:@"status"];
                [oneDic setObject:@"done" forKey:@"status"];
                break;
            default:
                break;
        }
    }
}
-(void)datePickerValueChanged:(id)sender
{
    UIDatePicker * datePicker = (UIDatePicker*)sender;
    if(datePicker.tag == 10)
    {
      
        _itemdate.text = [util getDateStringfordataFormant:@"yyyy-MM-dd" forData:datePicker.date];
        if(timeSelect.isChecked == YES)
        {
            [self.itemDic setObject:UNDT_DATE forKey:@"date"];
            [oneDic setObject:UNDT_DATE forKey:@"date"];
        }
        else
        {
            [self.itemDic setObject:_itemdate.text forKey:@"date"];
            [oneDic setObject:_itemdate.text forKey:@"date"];
        }
      
    }
    else if(datePicker.tag == 16)
    {
    
        _startTime.text = [util getDateStringfordataFormant:@"HH:MM" forData:datePicker.date];
        
        if(timeSelect.isChecked == YES)
        {
           [self.itemDic setObject:UNDT_DATE forKey:@"begin"];
           [oneDic setObject:UNDT_DATE forKey:@"begin"];
        }
        else
        {
           [self.itemDic setObject:[util getDateStringfordataFormant:@"HHMM" forData:datePicker.date] forKey:@"begin"];
            [oneDic setObject:[util getDateStringfordataFormant:@"HHMM" forData:datePicker.date] forKey:@"begin"];
        }
    
    }
    else if (datePicker.tag == 17)
    {
       
        _endTime.text = [util getDateStringfordataFormant:@"HH:MM" forData:datePicker.date];
        
        if(timeSelect.isChecked == YES)
        {
            [self.itemDic setObject:UNDT_DATE forKey:@"end"];
             [oneDic setObject:UNDT_DATE forKey:@"end"];
        }
        else
        {
            [self.itemDic setObject:[util getDateStringfordataFormant:@"HHMM" forData:datePicker.date] forKey:@"end"];
            [oneDic setObject:[util getDateStringfordataFormant:@"HHMM" forData:datePicker.date] forKey:@"end"];
            
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_name release];
    [_desc release];
    [_itemdate release];
    [_itemType release];
    [_itemPri release];
    [_descText release];
    [_descText release];
    [_stateText release];
    [_startTime release];
    [_endTime release];
    [_itemDateOk release];
    [_timingOk release];
    [_privateOk release];
    [_myScrollView release];
    [_compleButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setName:nil];
    [self setDesc:nil];
    [self setItemdate:nil];
    [self setItemType:nil];
    [self setItemPri:nil];
    [self setDescText:nil];
    [self setDescText:nil];
    [self setStateText:nil];
    [self setStartTime:nil];
    [self setEndTime:nil];
    [self setItemDateOk:nil];
    [self setTimingOk:nil];
    [self setPrivateOk:nil];
    [self setMyScrollView:nil];
    [self setCompleButton:nil];
    [super viewDidUnload];
}
-(void)mytouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_itemdate resignFirstResponder];
    [_itemType resignFirstResponder];
    [_itemPri  resignFirstResponder];
    [_name resignFirstResponder];
    [_desc resignFirstResponder];
    [_stateText resignFirstResponder];
    [_startTime resignFirstResponder];
    [_endTime resignFirstResponder];
    _datePicker.hidden = YES;
    
    
}
- (void)saveItem:(id)sender {
    
    if(_name.text.length == 0)
    {
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"标题不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [alter release];
    }
    else
    {
        [self.itemDic setObject:_name.text forKey:@"name"];
        [self.itemDic setObject:_desc.text forKey:@"desc"];
        [[httpLinker sharedHttpLinker] aditemforitemDic:self.itemDic];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)modifyItem:(id)sender
{
    if(_name.text.length==0)
    {
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"标题不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [alter release];
    }
    else
    {
        [oneDic setObject:_name.text forKey:@"name"];
        [oneDic setObject:_desc.text forKey:@"desc"];
        [[httpLinker sharedHttpLinker] edititemfordic:oneDic];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//完成未完成的待办事项
- (IBAction)compleItem:(id)sender {
    
    NSNumber * idNumber = [oneDic valueForKey:@"id"];
    [[httpLinker sharedHttpLinker] compleitemforId:idNumber];
    _compleButton.hidden = YES;
    _stateText.text = @"done";
}
@end
