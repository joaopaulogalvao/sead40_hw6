//
//  DatePickerViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/8/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

-(void)loadView{
  UIView *rootView = [[UIView alloc]init];
  UIDatePicker *datePicker = [[UIDatePicker alloc]init];
  
  [rootView addSubview:datePicker];
  
  UIButton *nextButton = [[UIButton alloc]init];
  
  [nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [nextButton setValue:@"Next" forKey:UIControlStateNormal];
  
  //Let me take control
  [nextButton setTranslatesAutoresizingMaskIntoConstraints:false];
  
  [rootView addSubview:nextButton];
  
  NSLayoutConstraint *nextButtonCenterX = [NSLayoutConstraint constraintWithItem:nextButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  
  nextButtonCenterX.active = true;
  
  NSLayoutConstraint *nextButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:nextButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]; // check
  
  nextButtonBottomConstraint.active = true;
  
  //check if there is another call
  
  self.view = rootView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  //Add type
  
}

-(void)nextButtonPressed:(UIButton *)sender {
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
