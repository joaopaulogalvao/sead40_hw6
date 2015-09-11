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
#import "Room.h"
#import "Hotel.h"
#import <CoreData/CoreData.h>

@interface ReserveYourRoomViewController ()

@property(strong, nonatomic) UITableView *tableViewReserveYourRoom;
@property(strong,nonatomic) NSArray *hotelsArray;
@property(strong,nonatomic) NSArray *roomsArray;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
//@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation ReserveYourRoomViewController


#pragma mark - Life cycle methods

-(void)loadView{
  
  UIView *rootView = [[UIView alloc]init];
  UITableView *tableView = [[UITableView alloc]initWithFrame:rootView.frame style:UITableViewStyleGrouped];
  
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
  
  NSFetchRequest *fetchRequestHotel = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  
  NSError *fetchError;
  
  self.hotelsArray = [appDelegate.managedObjectContext executeFetchRequest:fetchRequestHotel error:&fetchError];
  //self.roomsArray = [appDelegate.managedObjectContext executeFetchRequest:fetchRequestRoom error:&fetchError];
  
  
//  NSMutableArray *hotels = [NSMutableArray array];
//  
//  [self.roomsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//    
//    Room *room = [[Room alloc]init];
//    room.number = [self.roomsArray objectAtIndex:idx];
//    [hotels addObject:room];
//    
//  }];
//  
//  NSSortDescriptor *roomsWithSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotelsArray" ascending:true];
//  
//  NSLog(@"sort by rooms: %@",roomsWithSortDescriptor);
  
  if (fetchError) {
    NSLog(@"Error");
  }
  
  [self.tableViewReserveYourRoom reloadData];
  
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}

#pragma mark - NSFetchedResultController
-(NSFetchedResultsController *)fetchedResultsController {
  
  if (self.fetchedResultsController != nil) {
    return self.fetchedResultsController;
  }
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *fetchRequestRoom = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Hotel" inManagedObjectContext:appDelegate.managedObjectContext];
  
  [fetchRequestRoom setEntity:entity];
  
  NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"rooms.number" ascending:true];
  
  [fetchRequestRoom setSortDescriptors:[NSArray arrayWithObject:sort]];
  
  
  
  return self.fetchedResultsController;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  return self.hotelsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.roomsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
  
  // Configure the cell...
  
  Room *room = self.roomsArray[indexPath.section];
  cell.textLabel.text = [NSString stringWithFormat:@"%@",room.number];
  
  
  return cell;
  
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
