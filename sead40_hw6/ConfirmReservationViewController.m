//
//  ConfirmReservationViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/13/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "ConfirmReservationViewController.h"

@interface ConfirmReservationViewController ()

@property(strong, nonatomic) UIViewController *viewControllerConfirmYourReservation;

@end

@implementation ConfirmReservationViewController

-(void)loadView{
  
  //Create the view
  UIView *rootView = [[UIView alloc]init];
  
  //RootView - set it as a property of my viewController
  self.view = rootView;
  
  //Add Label first name
  
  //Add Label last name
  
  //Add TextField first name
  
  //Add TextField last name
  
  //Add Confirm reservation button
  
  //Add arrival date label
  
  //Add departure date label
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.title = @"Confirm Reservation";
  self.view.backgroundColor = [UIColor whiteColor];
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
