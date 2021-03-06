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
#import "ConfirmReservationViewController.h"

static NSString *const kMyFetchedResultsControllerCacheName = @"RootCache";

@interface ReserveYourRoomViewController ()

@property(strong, nonatomic) UITableView *tableViewReserveYourRoom;
@property(strong,nonatomic) NSArray *hotelsArray;
@property(strong,nonatomic) NSArray *roomsArray;
@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
//@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

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
  
//  NSDate *fromDate = self.selectedStartDate;
//  NSDate *toDate = self.selectedEndDate;
  
  [self.tableViewReserveYourRoom registerClass:[ReserveYourRoomTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];

  //[self fetchAvailableRoomsForFromDate:fromDate toDate:toDate];
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//
//  NSFetchRequest *fetchRequestHotel = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
//  NSFetchRequest *fetchRequestRoom = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
////
//  
  NSError *fetchError;
//  
//  self.hotelsArray = [appDelegate.managedObjectContext executeFetchRequest:fetchRequestHotel error:&fetchError];
//  self.roomsArray = [appDelegate.managedObjectContext executeFetchRequest:fetchRequestRoom error:&fetchError];
//  
//  NSLog(@"Hotels array: %lu",(unsigned long)self.hotelsArray.count);
  //[self fetchAvailableRoomsForFromDate:startDate toDate:endDate];
  
 [self.fetchedResultsController performFetch:&fetchError];
  
  if (fetchError != nil) {
    // Update to handle the error appropriately.
    NSLog(@"Unresolved error %@, %@", fetchError, [fetchError userInfo]);
    //exit(-1);  // Fail
  }
  
  self.title = @"Hotels";
  
  [self.tableViewReserveYourRoom reloadData];
  
  
}

-(void)viewDidUnload{
  [super viewDidUnload];
  self.fetchedResultsController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  // Instantiate the Confirmation View
  ConfirmReservationViewController *roomConfirmationView = [[ConfirmReservationViewController alloc]init];
  
  //Pass the selected room
  roomConfirmationView.selectedRoom = [self.fetchedResultsController objectAtIndexPath:indexPath];
  Room *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
  
  NSLog(@"Rooms for indexPath: %@",info);
  
  //Pass date references mark unavailable ones with something...
  roomConfirmationView.selectedConfirmStartDate = self.selectedStartDate;
  roomConfirmationView.selectedConfirmEndDate = self.selectedEndDate;
  
  NSLog(@"Selected Confirm Start Date: %@",roomConfirmationView.selectedConfirmStartDate);
  NSLog(@"Selected Confirm Departure Date: %@",roomConfirmationView.selectedConfirmEndDate);
  
  [self.navigationController pushViewController:roomConfirmationView animated:true];
  
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  id  sectionInfo =
  [[_fetchedResultsController sections] objectAtIndex:section];
  
  return [sectionInfo numberOfObjects];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  
  id <NSFetchedResultsSectionInfo> hotel = [self.fetchedResultsController sections][section];
  NSString *hotelName = hotel.name;
//  NSLog(@"sections: %@", hotel);
  return [NSString stringWithFormat:@"%@",hotelName];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  NSLog(@"%lu",(unsigned long)[[_fetchedResultsController sections] count]);
  
  return [[_fetchedResultsController sections] count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  
  Room *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@"%@",info.number];
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
  
  // Configure the cell...
  
  [self configureCell:cell atIndexPath:indexPath];
  
  
  return cell;
  
}


#pragma mark - NSFetchedResultController
-(NSFetchedResultsController *)fetchedResultsController {
  
  if (_fetchedResultsController == nil) {
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //[appDelegate.managedObjectContext reset];
    
    NSFetchRequest *fetchRequestHotel = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Room" inManagedObjectContext:appDelegate.managedObjectContext];
    
    [fetchRequestHotel setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"number" ascending:true];
    
    [fetchRequestHotel setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSFetchRequest *fetchRequestReservation = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    
    NSSortDescriptor *sortReservation = [[NSSortDescriptor alloc]initWithKey:@"room" ascending:true];
    
    [fetchRequestReservation setSortDescriptors:[NSArray arrayWithObject:sortReservation]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@",self.selectedEndDate,self.selectedStartDate];
    fetchRequestReservation.predicate = predicate;
    NSLog(@"Predicate: %@",predicate);
    
    NSError *fetchError;
    NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:fetchRequestReservation error:&fetchError];
    
    NSMutableArray *badRooms = [[NSMutableArray alloc] init];
    for (Reservation *reservation in results) {
      [badRooms addObject:reservation.room];
    }
    
    NSLog(@"Bad Rooms: %@",badRooms);
    
    NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
    finalRequest.predicate = finalPredicate;
    
    NSSortDescriptor *roomNumber = [[NSSortDescriptor alloc]initWithKey:@"number" ascending:true];
    
    [finalRequest setSortDescriptors:@[roomNumber]];
    
    NSFetchedResultsController *theFetchedResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:finalRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:@"Hotel.name" cacheName:nil];
    
    _fetchedResultsController = theFetchedResultController;
    _fetchedResultsController.delegate = self; // check
    
  }
  
  return _fetchedResultsController;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
  [self.tableViewReserveYourRoom beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  
  UITableView *tableView = self.tableViewReserveYourRoom;
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
      
    case NSFetchedResultsChangeMove:
      [tableView deleteRowsAtIndexPaths:[NSArray
                                         arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [tableView insertRowsAtIndexPaths:[NSArray
                                         arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [self.tableViewReserveYourRoom insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeMove:
      [self.tableViewReserveYourRoom insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeUpdate:
      [self.tableViewReserveYourRoom insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableViewReserveYourRoom deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
  [self.tableViewReserveYourRoom endUpdates];
}


#pragma mark - Rooms Availability




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
