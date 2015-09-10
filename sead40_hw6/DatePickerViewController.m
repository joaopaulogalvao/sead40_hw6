//
//  DatePickerViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/8/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "DatePickerViewController.h"
#import "DeparturePickerViewController.h"

@interface DatePickerViewController ()

@property (strong,nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSMutableArray *startDates;
@property (strong, nonatomic) NSDate *selectedStartDate;
@property (strong, nonatomic) NSDate *startDateFromString;

@end

@implementation DatePickerViewController

-(void)loadView{
  UIView *rootView = [[UIView alloc]init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  UIDatePicker *datePicker = [[UIDatePicker alloc]init];
  self.datePicker = datePicker;
  
  [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
  
  [rootView addSubview:datePicker];
  
  UIButton *nextButton = [[UIButton alloc]init];
  [nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [nextButton setTitle:NSLocalizedString(@"Next", nil)  forState:UIControlStateNormal];
  //Let me take control
  [nextButton setTranslatesAutoresizingMaskIntoConstraints:false];
  
  [rootView addSubview:nextButton];
  
  NSLayoutConstraint *nextButtonCenterX = [NSLayoutConstraint constraintWithItem:nextButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  nextButtonCenterX.active = true;
  NSLayoutConstraint *nextButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:nextButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-8];
  nextButtonBottomConstraint.active = true;
  
  //check if there is another call
  
  self.view = rootView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  //Add view's title
  self.title = NSLocalizedString(@"Select Arrival Date",nil);
  
  //Add type
  self.datePicker.datePickerMode = UIDatePickerModeDate;
  self.dateFormatter = [[NSDateFormatter alloc]init];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - My Actions

-(void)datePickerValueChanged:(UIDatePicker *)sender {
  
  //dateFormatter.dateStyle = NSDateFormatterShortStyle;
  [self.dateFormatter setDateFormat:@"MMMM dd yyyy"];
  NSString *dateString = [self.dateFormatter stringFromDate:sender.date];
  
  //Convert String to Date
  self.startDateFromString = [self.dateFormatter dateFromString:dateString];
  NSLog(@"Date String:%@",dateString);
  NSLog(@"Date: %@",self.startDateFromString);
}

-(void)nextButtonPressed:(UIButton *)sender {
  
  NSLog(@"Next button clicked.");
  
  //Pass the reference to departure...
  
  DeparturePickerViewController *departurePicker = [[DeparturePickerViewController alloc]init];
  
  departurePicker.selectedStartDate = self.startDateFromString;
  
  [self.navigationController pushViewController:departurePicker animated:true];
  
}

#pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
  
  self.selectedStartDate = [self.startDates objectAtIndex:row];
  NSLog(@"Selected Date: %@",[NSString stringWithFormat:@"%@",self.selectedStartDate]);
  
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
