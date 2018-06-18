//
//  LYCustomAlertView.m
//  OFO
//
//  Created by tianqiuqiu on 2017/11/3.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYCustomAlertView.h"

@interface LYCustomAlertView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property(nonatomic,strong)UIDatePicker*picker;
@property(nonatomic,strong)UIPickerView*pickView;
@property(nonatomic,copy)NSString*result;

@end

@implementation LYCustomAlertView

-(UIDatePicker *)picker{
    if (!_picker) {
        _picker=[UIDatePicker new];
        _picker.frame=CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
        _picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _picker.datePickerMode = UIDatePickerModeDate;
        _picker.maximumDate=[NSDate date];
    
    }
    return _picker;
}

-(UIPickerView *)pickView{
    if (!_pickView) {
        // 初始化pickerView
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height)];
        //指定数据源和委托
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bottomView addSubview:self.style==LYCustomAlertViewDateAlertStyle?self.picker:self.pickView];
}
#pragma pickViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataSource[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.result=self.dataSource[row];
}


//点击取消或者确定
- (IBAction)eventClick:(UIButton *)sender {
    if (sender.tag==1) {
        //取消
            [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(LYCustomAlertView:didSelectAlertResult:)]) {
            if (self.style==LYCustomAlertViewDefaultStyle) {
                //非时间格式
                if (self.result) {
                    [self.delegate LYCustomAlertView:self didSelectAlertResult:self.result];
                }else{
                    [self.delegate LYCustomAlertView:self didSelectAlertResult:self.dataSource[0]];
                }
            }else{
                //时间格式
                NSDate *date = self.picker.date;
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSString  *string = [[NSString alloc]init];
                string = [dateFormatter stringFromDate:date];
                [self.delegate LYCustomAlertView:self didSelectAlertResult:string];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)emptyClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
