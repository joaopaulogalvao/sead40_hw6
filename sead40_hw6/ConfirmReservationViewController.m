//
//  ConfirmReservationViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/13/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "ConfirmReservationViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"

@interface ConfirmReservationViewController ()

@property(strong, nonatomic) UIViewController *viewControllerConfirmYourReservation;
@property(strong, nonatomic) UILabel *firstNameLabel;



@end

@implementation ConfirmReservationViewController

-(void)loadView{
  
  //Create the view
  UIView *rootView = [[UIView alloc]init];
  
  rootView.backgroundColor = [UIColor whiteColor];
  
  //Create a label
  UILabel *firstNameLabel = [[UILabel alloc]init];
  
  //Create a button
  UIButton *submitButton = [[UIButton alloc]init];
  
  NSDictionary *views = @{@"viewControllerConfirmYourReservation" : rootView, @"firstNameLabel" : firstNameLabel, @"submitButton" : submitButton};
  
  //Set Label first name constraints
  firstNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
  firstNameLabel.backgroundColor = [UIColor redColor];
  firstNameLabel.numberOfLines = 0;
  firstNameLabel.text = @"First name:";
  [rootView addSubview:firstNameLabel];
  
  //Set Button constraints
  submitButton.translatesAutoresizingMaskIntoConstraints = NO;
  [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
  [submitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  //submitButton.backgroundColor = [UIColor blackColor];
  [rootView addSubview:submitButton];
  
  //Add Constraints to Submit Button
  NSArray *firstNameLabelVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[submitButton]-10-|" options:0 metrics:nil views:views];
  [rootView addConstraints:firstNameLabelVerticalConstraints];
  
  NSArray *firstNameLabelHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[submitButton]-100-|" options:0 metrics:nil views:views];
  [rootView addConstraints:firstNameLabelHorizontalConstraints];

  
  //Add constraints to first name label
  [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[firstNameLabel]" options:0 metrics:nil views:views]];
  [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[firstNameLabel]-50-|" options:0 metrics:nil views:views]];
  
  //Add Label last name
  
  //Add TextField first name
  
  //Add TextField last name
  
  //Add Confirm reservation button
  
  //Add arrival date label
  
  //Add departure date label
  
  //RootView - set it as a property of my viewController
  self.view = rootView;
  
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

#pragma mark - My Actions
-(void) bookReservation {
  
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:appDelegate.managedObjectContext];
  
  reservation.startDate = [NSDate date];
  reservation.endDate = [NSDate dateWithTimeInterval:86400 * 2 sinceDate:[NSDate date]];
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"number == 2"];
  NSError *fetchError;
  NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (results.count > 0) {
    Room *room = results.firstObject;
    reservation.room = room;
    NSError *saveError;
    if (![appDelegate.managedObjectContext save:&saveError]) {
      NSLog(@"%@",saveError.localizedDescription);
    }
    
  }
  
  
  
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
