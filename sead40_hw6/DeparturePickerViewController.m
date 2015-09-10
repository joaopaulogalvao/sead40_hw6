//
//  DeparturePickerViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/10/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "DeparturePickerViewController.h"
#import "ReserveYourRoomViewController.h"

@interface DeparturePickerViewController ()

@property (strong,nonatomic) UIDatePicker *departureDatePicker;
@property (strong,nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSMutableArray *departureDates;
@property (strong, nonatomic) NSDate *selectedDepartureDate;


@end

@implementation DeparturePickerViewController


-(void)loadView{
  UIView *rootView = [[UIView alloc]init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  UIDatePicker *datePicker = [[UIDatePicker alloc]init];
  self.departureDatePicker = datePicker;
  
  [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
  
  [rootView addSubview:datePicker];
  
  UIButton *nextButton = [[UIButton alloc]init];
  [nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [nextButton setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
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
  self.title = NSLocalizedString(@"Select Departure Date",nil);
  
  //Add type
  self.departureDatePicker.datePickerMode = UIDatePickerModeDate;
  self.dateFormatter = [[NSDateFormatter alloc]init];
  
  //Grab the arrival date reference
  NSLog(@"Arrival date: %@",self.selectedStartDate);
  
  //Write a test
  
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
  NSLog(@"%@",dateString);
}

-(void)nextButtonPressed:(UIButton *)sender {
  
  NSLog(@"Next button clicked.");
  
  //Pass both references to rooms and mark unavailable ones with something...
  ReserveYourRoomViewController *reserveYourRoomView = [[ReserveYourRoomViewController alloc]init];
  
  [self.navigationController pushViewController:reserveYourRoomView animated:true];
  
}

#pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
  
  self.selectedDepartureDate = [self.departureDates objectAtIndex:row];
  NSLog(@"Selected Date: %@",[NSString stringWithFormat:@"%@",self.selectedDepartureDate]);
  
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
