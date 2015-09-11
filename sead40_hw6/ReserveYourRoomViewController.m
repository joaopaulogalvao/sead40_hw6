//
//  ReserveYourRoomViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/10/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "ReserveYourRoomViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "ReserveYourRoomTableViewCell.h"

@interface ReserveYourRoomViewController ()

@property(strong, nonatomic) UITableView *tableViewReserveYourRoom;
@property(strong,nonatomic) NSArray *hotelsArray;

@end

@implementation ReserveYourRoomViewController

#pragma mark - Life cycle methods

-(void)loadView{
  
  UIView *rootView = [[UIView alloc]init];
  UITableView *tableView = [[UITableView alloc]initWithFrame:rootView.frame style:UITableViewStylePlain];
  
  self.tableViewReserveYourRoom = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView]; //check if there is method here
  
  NSDictionary *views = @{@"tableViewReserveYourRoom" : tableView};
  
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableViewReserveYourRoom]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewVerticalConstraints];
  
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableViewReserveYourRoom]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewHorizontalConstraints];
  
  self.view = rootView;
  
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  //Create and place in a "scratch pad" - now save
  self.tableViewReserveYourRoom.delegate = self;
  self.tableViewReserveYourRoom.dataSource = self;
  
  NSDate *fromDate = self.selectedStartDate;
  NSDate *toDate = self.selectedEndDate;
  
  [self.tableViewReserveYourRoom registerClass:[ReserveYourRoomTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];

  
  [self fetchAvailableRoomsForFromDate:fromDate toDate:toDate];
  
  
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  
  NSError *fetchError;
  
  self.hotelsArray = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  
  if (fetchError) {
    NSLog(@"Error");
  }
  
  [self.tableViewReserveYourRoom reloadData];
  
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}

#pragma mark - Rooms Availability 

-(NSArray *)fetchAvailableRoomsForFromDate:(NSDate*)fromDate toDate:(NSDate *)toDate {
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@",toDate,fromDate];
  request.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  NSMutableArray *badRooms = [[NSMutableArray alloc] init];
  for (Reservation *reservation in results) {
    [badRooms addObject:reservation.room];
  }
  
  NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
  finalRequest.predicate = finalPredicate;
  
  NSError *finalError;
  
  NSArray *finalResults = [appDelegate.managedObjectContext executeFetchRequest:finalRequest error:&finalError];
  
  if (finalError) {
    return nil;
  }
  return finalResults;
  
}


-(void) bookReservation {
  
  //  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  //
  //  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:appDelegate.managedObjectContext];
  
  
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
