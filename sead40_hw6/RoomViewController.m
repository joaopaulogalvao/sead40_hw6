//
//  RoomViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/9/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "RoomViewController.h"
#import "AppDelegate.h"
#import "Room.h"

@interface RoomViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *roomsArray;
@property(strong, nonatomic) UITableView *roomsTableView;




@end

@implementation RoomViewController

-(void)loadView{
  
  UIView *rootView = [[UIView alloc]init];
  UITableView *tableView = [[UITableView alloc]initWithFrame:rootView.frame style:UITableViewStylePlain];
  
  self.roomsTableView = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView]; //check if there is method here
  
  NSDictionary *views = @{@"roomsTableView" : tableView};
  
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[roomsTableView]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewVerticalConstraints];
  
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[roomsTableView]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewHorizontalConstraints];
  
  self.view = rootView;
  
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  //Create and place in a "scratch pad" - now save
  self.roomsTableView.delegate = self;
  self.roomsTableView.dataSource = self;
  
  [self.roomsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
  
  self.roomsArray = [self.selectedHotel.rooms allObjects];
  NSLog(@"%lu",(unsigned long)self.roomsArray.count);
  
  NSError *fetchError;

  NSLog(@"rooms array: %@",self.selectedHotel);
  
  if (fetchError) {
    NSLog(@"Error");
  }
  
  [self.roomsTableView reloadData];
  
  
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
  NSLog(@"Number of rows: %@",self.roomsArray);
  return [self.roomsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
  
  // Configure the cell...
  
  Room *room = [self.roomsArray objectAtIndex:indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@",room.number];
  
  
  return cell;
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
