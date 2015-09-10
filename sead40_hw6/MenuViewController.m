//
//  MenuViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/10/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "HotelListTableViewController.h"
#import "DatePickerViewController.h"
#import "LookUpReservationViewController.h"
#import "MenuViewController.h"
#import "MenuTableViewCell.h"

@interface MenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *menuTableView;

@property (strong, nonatomic) NSArray *tableData;

@end

@implementation MenuViewController

-(void)loadView{
  
  UIView *rootView = [[UIView alloc]init];
  UITableView *tableView = [[UITableView alloc]initWithFrame:rootView.frame style:UITableViewStyleGrouped];
  
  self.menuTableView = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView]; //check if there is method here
  
  NSDictionary *views = @{@"tableView" : tableView};
  
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewVerticalConstraints];
  
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewHorizontalConstraints];
  
  self.view = rootView;
  
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.menuTableView.delegate = self;
  self.menuTableView.dataSource = self;
  
  [self.menuTableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"MenuCellIdentifier"];
  
  self.tableData = [NSArray arrayWithObjects:NSLocalizedString(@"Browse Hotels",nil),NSLocalizedString(@"Book a Room",nil),NSLocalizedString(@"Lookup reservations", nil),nil];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *menuCell = [tableView dequeueReusableCellWithIdentifier:@"MenuCellIdentifier" forIndexPath:indexPath];
  
  menuCell.textLabel.text =  [self.tableData objectAtIndex:indexPath.row];
  
  return menuCell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  HotelListTableViewController *hotelView = [[HotelListTableViewController alloc]init];
  DatePickerViewController *dateView = [[DatePickerViewController alloc]init];
  LookUpReservationViewController *lookUpView = [[LookUpReservationViewController alloc]init];
  switch (indexPath.row) {
    case 0:
      [self.navigationController pushViewController:hotelView animated:true];
      break;
    case 1:
      [self.navigationController pushViewController:dateView animated:true];
      break;
    case 2:
      [self.navigationController pushViewController:lookUpView animated:true];
    default:
      break;
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
