//
//  HotelListTableViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/8/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "HotelListTableViewController.h"
#import "HotelTableViewCell.h"
#import "Hotel.h"
#import "AppDelegate.h"
#import "RoomViewController.h"

//static NSString *CellIdentifier = @"CellIdentifier";

@interface HotelListTableViewController () <UITableViewDataSource, UITableViewDelegate>


@property(strong,nonatomic) NSArray *hotelsArray;
@property(strong, nonatomic) UITableView *tableView;


@end

@implementation HotelListTableViewController

-(void)loadView{
  
  UIView *rootView = [[UIView alloc]init];
  UITableView *tableView = [[UITableView alloc]initWithFrame:rootView.frame style:UITableViewStylePlain];
  
  self.tableView = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView]; //check if there is method here
  
  NSDictionary *views = @{@"tableView" : tableView};
  
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewVerticalConstraints];
  
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewHorizontalConstraints];
  
  self.view = rootView;
  
}

//-(instancetype)initWithStyle:(UITableViewStyle)style{
//  
//  self = [super initWithStyle:style];
//  if (self) {
//    // Custom initialization
//    self.title = @"Table View Controller";
//  }
//  
//  return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
  
  //Create and place in a "scratch pad" - now save
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  
  
  [self.tableView registerClass:[HotelTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  
  //What do I want to fetch against?
  //Name - Atribute you are filtering on
  //MATCHES - Operator
  //%@(Wildcard) - What you are trying to compare against - Value
  //%K(substitute the value with the attribute) - values on your right will be in quotes
  //%@ - should be on your right
  
  fetchRequest.predicate = [NSPredicate predicateWithFormat:nil];
  
  NSError *fetchError;
  
  self.hotelsArray = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  
  if (fetchError) {
    NSLog(@"Error");
  }
  
  [self.tableView reloadData];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
  NSLog(@"%@",self.hotelsArray);
    return self.hotelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
  
  Hotel *hotel = self.hotelsArray[indexPath.row];
  cell.textLabel.text = hotel.name;
  
  
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  RoomViewController *roomListView = [[RoomViewController alloc]init];
  
  [self.navigationController pushViewController:roomListView animated:true];
  
  [self.tableView selectRowAtIndexPath:indexPath animated:true scrollPosition:UITableViewScrollPositionNone];
  
//  [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
  
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
